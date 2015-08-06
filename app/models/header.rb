# A header holds data for display at the top of a portfolio page
class Header
  include ValueObject.new(:title, :tagline, :intro)

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
