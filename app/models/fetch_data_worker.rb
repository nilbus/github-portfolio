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
    user_repos, other_repos = Repo.group_by_ownership(repos)
    portfolio = Portfolio.new(
      user: user,
      header: Header.generic(user),
      user_repos: user_repos,
      other_repos: other_repos,
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
