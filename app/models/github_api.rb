# Fetch data from the GitHub API.
#
# This class interfaces to a specific API gem implementation, and allows us to
# aggregate calls to fetch a single piece of information, when the API does not
# provide that information directly.
#
# rubocop:disable Metrics/ClassLength
#
class GithubAPI
  def initialize(github_username:, token: nil, cache: true)
    @github_username = github_username
    @querying_user = User.new(login: github_username)
    @object_from = ResponseObjectConverter.new(querying_user: @querying_user)
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
    @api.repositories(@github_username, all: true).map do |response_repo|
      @object_from.repo(response_repo)
    end
  end

  def starred_repos
    @api.starred(@github_username).map do |response_repo|
      @object_from.repo(response_repo)
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
      @object_from.repo(@api.repo(repo.full_name).parent)
    else
      repo
    end
  end

  def user_issues(repo:)
    @api.list_issues(repo.full_name, state: :all).map do |response_issue|
      @object_from.issue(response_issue, repo_full_name: repo.full_name)
    end
  end

  # Given an Issue, return a new Issue with closed_by detail
  def issue_detail(issue:) # rubocop:disable Metrics/MethodLength
    issue_response = @api.issue(issue.repo, issue.number)
    if issue_response.state == 'open'
      user_comment_count = issue_comment_count_by_user(
        issue_response: issue_response,
        repo_full_name: issue.repo,
      )
    end
    @object_from.issue(
      issue_response,
      repo_full_name: issue.repo,
      user_comment_count: user_comment_count,
    )
  end

  def user_commits(repo:)
    commits_response = @api.commits(repo.full_name, author: @github_username)
    commits_response.map { |response_commit| @object_from.commit(response_commit) }
  end

  def issue_comment_count_by_user(issue_response:, repo_full_name:)
    comments = with_max(100) do
      @api.issue_comments(repo_full_name, issue_response.number)
    end
    comments.count { |comment| comment.user.login == @github_username }
  end

  def contributors_stats(repo:)
    stats_response = @api.contributors_stats(repo.full_name)
    return Stats.new if stats_response.nil? # stats not ready
    stats_data = stats_response.map(&:to_attrs)
    Stats.new(user: @querying_user, contribution_stats_response: stats_data)
  end

  def version(repo:)
    version_from_release_object(repo: repo) || version_from_tag(repo: repo)
  end

  def version_from_release_object(repo:)
    release = @api.latest_release(repo.full_name)
    Version.new(name: release.name, date: release.published_at)
  rescue Octokit::NotFound
    nil
  end

  def version_from_tag(repo:)
    tag = @api.tags(repo.full_name).find { |t| t.name =~ /^v?\d+\./ }
    return if tag.nil?
    commit = @api.commit(repo.full_name, tag.commit.sha)
    Version.new(name: tag.name, date: commit.commit.committer.date)
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
