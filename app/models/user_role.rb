# Describe a user's role on a project based on their contribution statistics
class UserRole
  include ValueObject.new(:stats)

  def initialize(stats)
    @stats = stats
  end

  def to_s
    role_matchers.find { |condition, _role| condition.call }[1]
  end

  private

  # Matchers ordered by precedence
  def role_matchers
    {
      -> { only_one_committer }         => 'Sole Author',
      -> { authored_75_percent }        => 'Main Author',
      -> { authored_50_percent }        => 'Primary Contributor',
      -> { highest_commit_count }       => 'Largest Contributor',
      -> { top_half_committers }        => "Top #{@stats.tier} Contributor",
      -> { decent_commit_contribution } => 'Solid Contributor',
      -> { true }                       => 'Casual Contributor',
    }
  end

  def only_one_committer
    @stats.commit_count_user == @stats.commit_count_total
  end

  def authored_75_percent
    @stats.commits_authored_percentage >= 75
  end

  def authored_50_percent
    @stats.commits_authored_percentage >= 50
  end

  def highest_commit_count
    @stats.contribution_rank_by_commits == 1
  end

  def top_half_committers
    @stats.contribution_rank_by_commits <= @stats.total_contributors / 2.0
  end

  def decent_commit_contribution
    decent_commit_percentage || decent_commit_count
  end

  def decent_commit_percentage
    @stats.commits_authored_percentage >= 20
  end

  def decent_commit_count
    @stats.commit_count_user >= 10
  end
end
