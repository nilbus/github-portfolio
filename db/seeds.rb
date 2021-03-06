user = User.new(
  name: 'Linda Hand',
  login: 'test'
)
issue = Issue.new(
  number: 1,
  title: "Can't get you out of my head",
  assigned_to: nil,
  created_by: "test",
  closed_by: "test",
  has_user_commentary: false,
  repo: "nilbus/handoff",
  state: "closed",
  url: "https://github.com/nilbus/handoff/issues/1",
)
pull_request = Issue.new(
  number: 2,
  title: "Force remove you from my head",
  created_by: "test",
  closed_by: "test",
  state: "closed",
  url: "https://github.com/nilbus/handoff/pull/2",
)
comment = Comment.new(
  body: 'This is a great idea!',
  url: 'https://github.com/nilbus/handoff/pull/1#issuecomment-71632498',
  author: 'test',
)
commit = Commit.new(
  sha: '6d1ad5f65777a59b73b09bf34cc06b0c1fec5998',
  author: 'test',
  message: "Refactor the god object\n\nNow instead, we have many gods.\n",
  url: "https://github.com/nilbus/handoff/commit/74220568b66b912df499d0503678c287916b831c",
)
version = Version.new(name: 'v1.4.0', date: 3.months.ago.to_time)
repo = Repo.new(
  created_at: Time.parse('Aug 2008'),
  description: 'A dual (localStorage and REST) sync adapter for Backbone.js',
  fork: false,
  primary_language: 'Coffeescript',
  languages: ['Javascript', 'Coffeescript'],
  name: 'Backbone.dualStorage',
  owner: user,
  releases_url: '',
  reporting_period: '3 months',
  star_count: 10548,
  querying_user: user,
  stats: Stats.new,
  user_is_collaborator: true,
  url: 'https://github.com/nilbus/Backbone.dualStorage',
  version: version,
  issues: [issue, pull_request],
  issues_url: 'https://github.com/nilbus/Backbone.dualStorage/issues',
  user_comments: [comment],
  user_commits: [commit],
  user_commits_url: '',
)
portfolio = Portfolio.new(
  header: Header.generic(user),
  user: user,
  user_repos: [repo],
  other_repos: [repo],
)
PortfolioStore.new.save(portfolio)
