user = User.new(
  name: 'Linda Hand',
  login: 'test'
)
repo = Repo.new(
  author_commit_count_this_year: 1024,
  created_month_year: 'Aug 2008',
  description: 'A dual (localStorage and REST) sync adapter for Backbone.js',
  languages: ['Coffeescript', 'Javascript'],
  name: 'Backbone.dualStorage',
  release_age: '7 years',
  reporting_period: '3 months',
  star_count: 10548,
  url: 'https://github.com/nilbus/Backbone.dualStorage',
  version: 'v1.4.0',
  issues: [],
  user_comments: [],
  user_commits: [],
)
portfolio = Portfolio.new(
  header: Header.generic(user),
  user: user,
  user_repos: [repo],
  other_repos: [repo],
)
PortfolioStore.new.save(portfolio)
