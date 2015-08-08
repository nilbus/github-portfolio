# A presenter value object that provides convenience methods to access all the
# data needed to render a portfolio.
class Portfolio
  include ValueObject.new(:user, :header, :user_repos, :other_repos)

  def initialize(*)
    super
    self.header ||= Header.generic(user)
  end

  def name
    user.name
  end

  def user_projects_with_user_activity
    user_repos.select(&:reports_activity?)
  end

  def other_projects_with_user_activity
    other_repos.select(&:reports_activity?)
  end

  def serialize
    Marshal.dump(self)
  end

  def self.load(serialized_user)
    Marshal.load(serialized_user)
  end
end
