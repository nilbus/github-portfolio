# frozen_string_literal: true

# An adapter/facade to GithubAPI that fetches Repo objects for a User with a
# particualar ownership context.
#
# user_repos: the set of repositories the user owns (or has commit access to)
# other_repo: the set of repositories that are parents of the user's forks
#
class UserRepos
  def initialize(github_username, api_token:)
    @github = GithubAPI.new(github_username: github_username, token: api_token)
  end

  def user
    @github.user
  end

  def user_repos
    @user_repos ||= begin
      repos = considered_repos.select(&:user_is_owner_or_collaborator?)
      repos.each { |repo| detail_user_repo!(repo) }
    end
  end

  def other_repos
    @other_repos ||= begin
      repos = considered_repos.reject(&:user_is_owner_or_collaborator?)
      repos.each { |repo| detail_other_repo!(repo) }
    end
  end

  private

  def considered_repos
    @considered_repos ||= begin
      repos = @github.self_starred_repos
      repos.map do |repo|
        @github.substitute_parent_for_fork(repo)
      end
    end
  end

  def detail_user_repo!(repo)
    issues = @github.with_max(100) { @github.issues(repo: repo) }
    repo.issues = issues.map { |issue| @github.issue_detail(issue: issue) }
    repo.user_commits = @github.with_max(5) do
      @github.user_commits(repo: repo)
    end
    repo.stats = @github.contributors_stats(repo: repo)
    repo.version = @github.version(repo: repo)
    # TODO: Detect special language overrides (#1) and frameworks (#2)
    repo.user_comments = []
  end

  def detail_other_repo!(repo)
    repo.user_commits = []
    repo.user_comments = []
    repo.issues = @github.user_pull_requests(repo: repo)
    return if repo.issues.any?

    repo.issues = @github.user_issues(repo: repo)
    return if repo.issues.any?

    repo.user_commits = @github.user_commits(repo: repo)
    # return if repo.user_commits.any?
    # # TODO: Load my comments
    # repo.user_comments = []
  end
end
