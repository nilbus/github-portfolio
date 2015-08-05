# A header holds data for display at the top of a portfolio page
class Header
  include ValueObject.new(:title, :tagline, :intro)

  def self.generic(user)
    Header.new(
      title: user.name,
      tagline: 'Code Portfolio',
      intro: <<-INTRO
        This is an auto-generated portfolio for the GitHub user #{user.login}.
      INTRO
    )
  end
end
