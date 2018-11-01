# frozen_string_literal: true

# A Comment value object.
#
# A GitHub comment can be attached to either a commit, an issue, or a specific line
# in a pull request.
class Comment
  include ValueObject.new(:body, :url, :author)

  def preview
    body
  end
end
