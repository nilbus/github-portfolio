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
    maximums = {
      commit_count: repos.map { |repo| repo.stats.commit_count_user }.max,
      star_count: repos.map(&:star_count).max,
    }
    repos.sort_by { |repo| -repo.relevance(maximums: maximums) }
  end

  def other_projects_with_user_activity
    repos = other_repos.select(&:reports_activity?)
    maximums = {
      commit_count: repos.map { |repo| repo.user_commits.size }.max,
      star_count: repos.map(&:star_count).max,
    }
    repos.sort_by { |repo| -repo.relevance(maximums: maximums) }
  end

  def serialize
    Marshal.dump(self)
  end
end
