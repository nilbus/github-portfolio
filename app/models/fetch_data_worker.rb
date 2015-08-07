# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token only needs to grant
# public access.
#
class FetchDataWorker
  def initialize(github_username)
    @github = GithubAPI.new(github_username: github_username, token: api_token)
  end

  def perform
    user = @github.user
    user_repos, other_repos = fetch_revelant_repos_with_data
    portfolio = Portfolio.new(
      user: user,
      header: Header.generic(user),
      user_repos: user_repos.sort_by(&:star_count).reverse,
      other_repos: other_repos,
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  def fetch_revelant_repos_with_data
    repos = @github.self_starred_repos
    reporting_repos = repos.map do |repo|
      @github.substitute_parent_for_fork(repo)
    end
    user_repos, other_repos = Repo.group_by_ownership(reporting_repos)
    user_repos.each  { |repo| detail_user_repo!(repo) }
    other_repos.each { |repo| detail_other_repo!(repo) }
    [user_repos, other_repos]
  end

  def detail_user_repo!(repo)
    issues = @github.with_max(100) { @github.user_issues(repo: repo) }
    repo.issues = issues.map { |issue| @github.issue_detail(issue: issue) }
    repo.user_commits = @github.with_max(5) do
      @github.user_commits(repo: repo)
    end
    # TODO: Load contribution stats
    # TODO: Calculate total commit count
    # TODO: Load release info
    # TODO: Detect special language overrides (#1) and frameworks (#2)
    repo.user_comments = []
  end

  def detail_other_repo!(repo)
    repo.issues = []
    repo.user_commits = []
    repo.user_comments = []
    # # TODO: Load MY issues & PRs
    # repo.issues = []
    # repo.user_commits = []
    # repo.user_comments = []
    # reutrn if repo.issues.any?
    # # TODO: Load recent authored commits
    # repo.user_commits = []
    # reutrn if repo.user_commits.any?
    # # TODO: Load my comments
    # repo.user_comments = []
  end

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
