# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token only needs to grant
# public access.
#
class FetchDataWorker
  def initialize
    @github = GithubAPI.new(token: api_token)
  end

  def perform(github_username) # rubocop:disable Metrics/MethodLength
    user = @github.user(github_username)
    repos = @github.self_starred_repos(github_username)
    reporting_repos = repos.map do |repo|
      @github.substitute_parent_for_fork(repo, github_username: github_username)
    end
    user_repos, other_repos = Repo.group_by_ownership(reporting_repos)
    user_repos.each  { |repo| detail_user_repo!(repo) }
    other_repos.each { |repo| detail_other_repo!(repo) }
    portfolio = Portfolio.new(
      user: user,
      header: Header.generic(user),
      user_repos: user_repos.sort_by(&:star_count).reverse,
      other_repos: other_repos,
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  def detail_user_repo!(repo)
    # TODO: Load recent authored commits
    # TODO: Detect special language overrides (#1) and frameworks (#2)
    # TODO: Load contribution stats
    # TODO: Load RECENT issues & PRs
    repo.issues = []
    repo.user_commits = []
    repo.user_comments = []
    # TODO: Load release info
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
