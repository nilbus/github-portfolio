# frozen_string_literal: true

# A GitHub Issue / Pull Request value object
class Issue
  include ValueObject.new(:number, :title, :assigned_to, :closed_by, :created_by, :has_user_commentary, :pull_request, :repo, :state, :url)

  def resolved_by?(user)
    return false unless resolved?

    closed_by == user || assigned_to == user
  end

  def created_by?(user)
    created_by == user
  end

  def user_commentary?
    has_user_commentary
  end

  def open?
    state == 'open'
  end

  def resolved?
    state == 'closed' || state == 'merged'
  end

  def merged?
    state == 'merged'
  end
end
