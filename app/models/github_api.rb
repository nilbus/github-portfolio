# Fetch data from the GitHub API.
#
# This class interfaces to a specific API gem implementation, and allows us to
# aggregate calls to fetch a single piece of information, when the API does not
# provide that information directly.
#
class GithubAPI
  def initialize(token: nil, cache: true)
    @api = Octokit::Client.new access_token: token
    @api.auto_paginate = true
    @api.per_page = 100
    configure_cache if cache
  end

  def user(github_username)
    response = @api.user(github_username)
    User.new(name: response.name, login: response.login)
  end

  # Filtering for private repos is unnecessary w/ only public_repo access
  def public_repos(github_username)
    @api.repositories(github_username, all: true).map do |repo|
      repo_from_response(repo, github_username: github_username)
    end
  end

  def starred_repos(github_username)
    @api.starred(github_username).map do |repo|
      repo_from_response(repo, github_username: github_username)
    end
  end

  def self_starred_repos(github_username)
    repos = Set.new(public_repos(github_username))
    starred = Set.new(starred_repos(github_username))
    repos.intersection(starred)
  end

  def check_collaborator?(repo, github_username)
    return true if repo.owner.login == github_username
    @api.collaborator?(repo_full_name, github_username)
  rescue Octokit::Forbidden
    false
  end

  private

  # rubocop:disable Metrics/MethodLength
  def repo_from_response(response, github_username:)
    repo = substitute_parent_for_fork(response)
    Repo.new(
      full_name: repo.full_name,
      name: repo.name,
      description: repo.description,
      created_at: repo.created_at,
      owner_login: repo.owner.login,
      primary_language: repo.language,
      querying_user: User.new(login: github_username),
      star_count: repo.stargazers_count,
      url: repo.html_url,
    )
  end
  # rubocop:enable Metrics/MethodLength

  def substitute_parent_for_fork(repo_response)
    if repo_response.fork
      @api.repo(repo_response.full_name).parent
    else
      repo_response
    end
  end

  def configure_cache
    @api.middleware = prepend_middleware_to(Octokit.middleware) do |builder|
      builder.use Faraday::HttpCache, store: Rails.cache
    end
  end

  def prepend_middleware_to(original_rack_stack)
    Faraday::RackBuilder.new do |builder|
      yield builder
      original_rack_stack.handlers.each do |handler|
        builder.use(handler.klass)
      end
    end
  end
end
