# Fetch data from the GitHub API.
#
# This class interfaces to a specific API gem implementation, and allows us to
# aggregate calls to fetch a single piece of information, when the API does not
# provide that information directly.
#
class GithubAPI # rubocop:disable Metrics/ClassLength
  def initialize(github_username:, token: nil, cache: true)
    @github_username = github_username
    @api = Octokit::Client.new access_token: token
    @api.auto_paginate = true
    @api.per_page = 100
    configure_cache if cache
  end

  def user
    response = @api.user(@github_username)
    User.new(name: response.name, login: response.login)
  end

  # Filtering for private repos is unnecessary w/ only public_repo access
  def public_repos
    @api.repositories(@github_username, all: true).map do |repo|
      repo_from_response(repo)
    end
  end

  def starred_repos
    @api.starred(@github_username).map do |repo|
      repo_from_response(repo)
    end
  end

  def self_starred_repos
    repos = Set.new(public_repos)
    starred = Set.new(starred_repos)
    repos.intersection(starred)
  end

  def check_collaborator?(repo)
    return true if repo.owner.login == @github_username
    @api.collaborator?(repo_full_name)
  rescue Octokit::Forbidden
    false
  end

  def substitute_parent_for_fork(repo)
    if repo.fork
      repo_from_response(@api.repo(repo.full_name).parent)
    else
      repo
    end
  end

  def user_issues(repo:)
    @api.list_issues(repo.full_name, state: :all).map do |issue_response|
      issue_from_response(issue_response, repo_full_name: repo.full_name)
    end
  end

  # Given an Issue, return a new Issue with closed_by detail
  def issue_detail(issue:)
    issue_response = @api.issue(issue.repo, issue.number)
    issue_from_response(issue_response, repo_full_name: issue.repo)
  end

  def with_max(max)
    max = max.to_i
    if max > 100 || max <= 0
      fail ArgumentError, "max must be <= 100, GitHub's maximum per_page value"
    end
    previous_values = @api.auto_paginate, @api.per_page
    @api.auto_paginate, @api.per_page = false, max
    yield
  ensure
    @api.auto_paginate, @api.per_page = previous_values
  end

  private

  # rubocop:disable Metrics/MethodLength
  def repo_from_response(response)
    Repo.new(
      full_name: response.full_name,
      name: response.name,
      description: response.description,
      created_at: response.created_at,
      fork: response.fork,
      owner: user_from_response_user(response.owner),
      primary_language: response.language,
      querying_user: User.new(login: @github_username),
      star_count: response.stargazers_count,
      url: response.html_url,
    )
  end

  # rubocop:disable Metrics/AbcSize
  def issue_from_response(response, repo_full_name:)
    if response.state == 'open'
      user_comment_count = issue_comment_count_by_user(
        issue_response: response,
        repo_full_name: repo_full_name,
      )
    end
    Issue.new(
      number: response.number,
      title: response.title,
      assigned_to: user_from_response_user(response.assignee),
      closed_by: user_from_response_user(response.closed_by),
      created_by: user_from_response_user(response.user),
      has_user_commentary: user_comment_count && user_comment_count > 0,
      pull_request: response.pull_request.present?,
      repo: repo_full_name,
      state: response.state,
      url: response.html_url,
    )
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def user_from_response_user(response_user)
    return nil unless response_user.present?
    User.new(login: response_user.login, name: response_user.name.presence)
  end

  def issue_comment_count_by_user(issue_response:, repo_full_name:)
    comments = with_max(100) do
      @api.issue_comments(repo_full_name, issue_response.number)
    end
    comments.count { |comment| comment.user.login == @github_username }
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
