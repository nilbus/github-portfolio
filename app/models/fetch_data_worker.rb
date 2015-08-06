# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token only needs to grant
# public access.
#
class FetchDataWorker
  def initialize
    @github = GithubAPI.new(token: api_token)
  end

  def perform(github_username)
    user = @github.user(github_username)
    repos = @github.self_starred_repos(github_username)
    portfolio = Portfolio.new(
      user: user,
      header: Header.generic(user),
      user_repos: @github.user_repos(repos),
      other_repos: @github.other_repos(repos),
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
