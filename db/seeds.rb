user = User.new(
  name: 'Linda Hand',
  login: 'test'
)
issue = Issue.new(
  number: 1,
  title: "Can't get you out of my head",
  created_by: "test",
  closed_by: "test",
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
repo = Repo.new(
  author_commit_count_this_year: 1024,
  created_at: Time.parse('Aug 2008'),
  description: 'A dual (localStorage and REST) sync adapter for Backbone.js',
  languages: ['Coffeescript', 'Javascript'],
  name: 'Backbone.dualStorage',
  owner_login: 'test',
  release_age: '7 years',
  releases_url: '',
  reporting_period: '3 months',
  star_count: 10548,
  querying_user: user,
  user_is_collaborator: true,
  url: 'https://github.com/nilbus/Backbone.dualStorage',
  version: 'v1.4.0',
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
