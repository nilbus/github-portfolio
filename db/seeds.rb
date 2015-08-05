user = User.new(
  name: 'Linda Hand',
  login: 'test'
)
portfolio = Portfolio.new(
  header: Header.generic(user),
  user: user
)
PortfolioStore.new.save(portfolio)
