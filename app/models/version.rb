# frozen_string_literal: true

# A versioned release for a repository
class Version
  include ValueObject.new(:name, :date)
  include ActionView::Helpers::DateHelper

  def to_s
    name.sub(/^v/, '')
  end

  def age
    time_ago_in_words(date) if date
  end
end
