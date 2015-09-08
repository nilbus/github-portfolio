# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token only needs to grant
# public access.
#
class FetchDataWorker
  def initialize(github_username)
    @repos = UserRepos.new(github_username, api_token: api_token)
  end

  def perform
    portfolio = Portfolio.new(
      user: @repos.user,
      header: Header.for(@repos.user),
      user_repos: @repos.user_repos.sort_by(&:star_count).reverse,
      other_repos: @repos.other_repos,
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  private

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
