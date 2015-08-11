# A presenter value object that provides convenience methods to access all the
# data needed to render a portfolio.
class Portfolio
  include ValueObject.new(:user, :header, :user_repos, :other_repos)

  def self.load(serialized_user)
    Marshal.load(serialized_user)
  end

  def initialize(*)
    super
    self.header ||= Header.generic(user)
  end

  def name
    user.name
  end

  def user_projects_with_user_activity
    repos = user_repos.select(&:reports_activity?)
    repos.sort_by { |repo| -RepoRelevance.new(repo: repo, all_repos: repos).to_i }
  end

  def other_projects_with_user_activity
    repos = other_repos.select(&:reports_activity?)
    repos.sort_by { |repo| -RepoRelevance.new(repo: repo, all_repos: repos).to_i }
  end

  def serialize
    Marshal.dump(self)
  end
end
