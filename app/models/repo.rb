# frozen_string_literal: true

# A GitHub project and its data
#
class Repo
  include Entity.new(:full_name)
  attr_accessor(:created_at, :description, :fork, :full_name, :issues, :issues_url, :primary_language, :languages, :name, :owner, :releases_url, :reporting_period, :star_count, :url, :querying_user, :stats, :user_is_collaborator, :user_comments, :user_commits, :user_commits_url, :version)

  def description
    @description.try(&:strip) || ''
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

  def user_role
    UserRole.new(stats).to_s
  end

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

  def user_commit_count
    stats.try(:commit_count_user) || user_commits.size
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
end
