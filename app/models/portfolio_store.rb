# Persist and load Portfolio objects
class PortfolioStore
  def find(github_username)
    data = store.fetch(key_for(github_username))
    Portfolio.load(data) if data
  end

  def key_for(github_username)
    "github_user:#{github_username}"
  end

  def store
    Rails.cache
  end

  def save(portfolio)
    store.write(key_for(portfolio.user.login), portfolio.serialize)
  end
end
