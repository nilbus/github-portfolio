# A GitHub project and its data
#
# rubocop:disable Metrics/ClassLength
#
class Repo
  include Entity.new(:full_name)
  attr_accessor(*%i(
    created_at
    description
    fork
    full_name
    issues
    issues_url
    primary_language
    languages
    name
    owner
    releases_url
    reporting_period
    star_count
    url
    querying_user
    stats
    user_is_collaborator
    user_comments
    user_commits
    user_commits_url
    version
  ))

  def self.group_by_ownership(repos)
    # rubocop:disable Style/DoubleNegation
    groups = repos.group_by { |repo| !!repo.user_is_owner_or_collaborator? }
    owned = groups[true] || []
    other = groups[false] || []
    [owned, other]
  end

  def created_month_year
    created_at.strftime('%b %Y')
  end

  def language
    primary_language
  end

  def user_contribution_percentage
    [stats.commits_authored_percentage, stats.lines_added_percentage].max
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def user_role
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
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def user_resolved_issues
    issues.select { |issue| issue.resolved_by?(querying_user) }
  end

  def user_triaged_issues
    issues.select do |issue|
      issue.open? &&
        (issue.user_commentary? || issue.created_by?(querying_user))
    end
  end

  def unresolved_issue_count
    issues.count(&:open?)
  end

  def user_is_owner?
    querying_user == owner
  end

  def user_is_owner_or_collaborator?
    user_is_owner? || user_is_collaborator
  end

  def pull_requests
    issues.select(&:pull_request)
  end

  def user_pull_requests
    pull_requests.select { |pull_request| pull_request.created_by == querying_user }
  end

  def user_pull_requests_accepted
    user_pull_requests.select(&:merged?)
  end

  def user_opened_issues
    issues.select do |issue|
      !issue.pull_request && issue.created_by == querying_user
    end
  end

  def reports_activity?
    user_pull_requests.any? || user_opened_issues.any? || user_commits.any? ||
      user_resolved_issues.any? || user_triaged_issues.any?
  end

  # rubocop:disable Metrics/LineLength, Metrics/AbcSize, Metrics/MethodLength
  def relevance(maximums: {})
    factors = [
      RelevanceFactor.new(:commits, 2) { user_commits.size / maximums.fetch(:commit_count).to_f },
      RelevanceFactor.new(:stars, 3) { star_count / maximums.fetch(:star_count).to_f },
    ]
    if user_is_collaborator
      factors += [
        RelevanceFactor.new(:age, 3) { ((version.date || created_at) - 3.years.ago) / 3.years.to_f },
        RelevanceFactor.new(:issues_resolved, 2) { user_resolved_issues.size / issues.size.to_f },
        RelevanceFactor.new(:issues_triaged, 2) { user_triaged_issues.size / unresolved_issue_count.to_f },
      ]
    else
      factors += [
        RelevanceFactor.new(:percent_pull_requests_accepted, 3) { user_pull_requests_accepted.size / user_pull_requests.size.to_f },
        RelevanceFactor.new(:number_pull_requests_accepted, 5) { [5, user_pull_requests_accepted.size].max / 5.0 },
        RelevanceFactor.new(:issues_created, 3) { [5, user_opened_issues.size].max / 5.0 },
      ]
    end
    RelevanceFactor.calculate(factors)
  end
  # rubocop:enable Metrics/LineLength, Metrics/AbcSize, Metrics:MethodLength
end
