# A GitHub project and its data
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
    release_age
    releases_url
    reporting_period
    star_count
    url
    querying_user
    total_commit_count
    user_is_collaborator
    user_comments
    user_commits
    user_commits_url
    version
  ))

  def created_month_year
    created_at.strftime('%b %Y')
  end

  def language
    primary_language
  end

  def user_role
    'Mystery Contributor'
  end

  def user_role_description
    'did some stuff'
  end

  def user_contribution_percentage
    -1
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

  def pull_requests
    issues
  end

  def user_pull_requests
    pull_requests
  end

  def user_pull_requests_accepted
    user_pull_requests
  end

  def user_opened_issues
    issues
  end

  def self.group_by_ownership(repos)
    # rubocop:disable Style/DoubleNegation
    groups = repos.group_by { |repo| !!repo.user_is_owner_or_collaborator? }
    owned = groups[true] || []
    other = groups[false] || []
    [owned, other]
  end
end
