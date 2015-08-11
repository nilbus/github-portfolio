# Describe a user's role on a project based on their contribution statistics
class UserRole
  include ValueObject.new(:stats)

  def initialize(stats)
    @stats = stats
  end

  def to_s
    case
    when stats.commit_count_user == stats.commit_count_total
      'Sole Author'
    when stats.commits_authored_percentage >= 75
      'Main Author'
    when stats.commits_authored_percentage >= 50
      'Primary Contributor'
    when stats.contribution_rank_by_commits == 1
      'Largest Contributor'
    when stats.contribution_rank_by_commits <= stats.total_contributors / 2.0
      "Top #{stats.tier} Contributor"
    when stats.commits_authored_percentage >= 20 || stats.commit_count_user >= 10
      'Solid Contributor'
    else
      'Casual Contributor'
    end
  end
end
