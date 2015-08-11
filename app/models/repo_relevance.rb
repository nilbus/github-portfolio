# Determine how relevant a repository is based on several RelevanceFactors.
# This correlates with a repository's prominence.
#
class RepoRelevance
  include ValueObject.new(:repo, :all_repos)

  def to_i
    weighted_values = factors.map do |factor|
      value = factor.value.to_f
      value = 0 if value.nan? || !value.finite?
      value * factor.weight.to_f
    end
    weighted_values.inject(:+) || 0
  end
  memoize :to_i

  def repo_maximums
    {
      commit_count: @all_repos.map(&:user_commit_count).max,
      star_count: @all_repos.map(&:star_count).max,
    }
  end
  memoize :repo_maximums

  private

  def factors
    core_factors + factors_for_collaborator_type
  end

  def core_factors
    [
      relevance_factor(weight: 2, value: authored_commits),
      relevance_factor(weight: 3, value: star_count),
    ]
  end

  def factors_for_collaborator_type
    @repo.user_is_collaborator ? user_repo_factors : other_repo_factors
  end

  def user_repo_factors
    [
      relevance_factor(weight: 3, value: release_or_creation_age),
      relevance_factor(weight: 2, value: issues_resolved),
      relevance_factor(weight: 2, value: issues_triaged),
    ]
  end

  def other_repo_factors
    [
      relevance_factor(weight: 3, value: percent_pull_requests_accepted),
      relevance_factor(weight: 5, value: number_pull_requests_accepted),
      relevance_factor(weight: 3, value: issues_created),
    ]
  end

  def relevance_factor(weight:, value:)
    RelevanceFactor.new(weight: weight, value: value)
  end

  def authored_commits
    @repo.user_commits.size / repo_maximums.fetch(:commit_count).to_f
  end

  def star_count
    @repo.star_count / repo_maximums.fetch(:star_count).to_f
  end

  def release_or_creation_age
    ((@repo.version.date || @repo.created_at) - 3.years.ago) / 3.years.to_f
  end

  def issues_resolved
    @repo.user_resolved_issues.size / @repo.issues.size.to_f
  end

  def issues_triaged
    @repo.user_triaged_issues.size / @repo.unresolved_issue_count.to_f
  end

  def percent_pull_requests_accepted
    @repo.user_pull_requests_accepted.size / @repo.user_pull_requests.size.to_f
  end

  def number_pull_requests_accepted
    [5, @repo.user_pull_requests_accepted.size].max / 5.0
  end

  def issues_created
    [5, @repo.user_opened_issues.size].max / 5.0
  end
end
