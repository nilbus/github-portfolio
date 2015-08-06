# A GitHub project and its data
class Repo
  include ValueObject.new(*%i(
    author_commit_count_this_year
    created_at
    description
    full_name
    issues
    issues_url
    primary_language
    languages
    name
    owner_login
    release_age
    releases_url
    reporting_period
    star_count
    url
    querying_user
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
    'Sole Author'
  end

  def user_role_description
    'authored every commit'
  end

  def user_contribution_percentage
    100
  end

  def user_resolved_issues
    issues
  end

  def user_triaged_issues
    issues
  end

  def unresolved_issues
    []
  end

  def user_is_owner?
    querying_user.login == owner_login
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
end
