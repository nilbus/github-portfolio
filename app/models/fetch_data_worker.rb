# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token only needs to grant
# public access.
#
class FetchDataWorker
  def perform(github_username)
    api = GithubAPI.new(token: api_token)
    user = api.user(github_username)
    portfolio = Portfolio.new(user: user)
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
