# frozen_string_literal: true

# Fetch the profile data for a GitHub user, and store results in a PortfolioStore.
#
# A GitHub API token is loaded from config/secrets.yml. The token needs to grant
# public_repo access.
#
class FetchDataWorker
  def initialize(github_username)
    @user_repos = UserRepos.new(github_username, api_token: api_token)
  end

  def perform
    portfolio = Portfolio.new(
      user: @user_repos.user,
      header: Header.for(@user_repos.user),
      user_repos: @user_repos.user_repos.sort_by(&:star_count).reverse,
      other_repos: @user_repos.other_repos,
    )
    PortfolioStore.new.save(portfolio)
    portfolio
  end

  private

  def api_token
    Rails.application.secrets[:github_api_token]
  end
end
