# frozen_string_literal: true

# A header holds data for display at the top of a portfolio page
#
# Attributes:
#  * github_username : string
#  * title           : string
#  * tagline         : string
#  * intro           : text
#
class Header < ActiveRecord::Base
  validates :github_username, uniqueness: true

  def self.for(user)
    find_by(github_username: user.login) || generic(user)
  end

  def self.generic(user)
    Header.new(
      title: user.name,
      tagline: 'Code Portfolio',
      intro: <<-INTRO
        This is an auto-generated portfolio for the GitHub user #{user.login}.
        Remember, only self-starred repositories that you own will appear here.
        Starring your fork will highlight your contributions to the parent.
      INTRO
    )
  end
end
