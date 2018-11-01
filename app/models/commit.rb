# frozen_string_literal: true

# A value object representing a GitHub commit
class Commit
  include ValueObject.new(:sha, :author, :message, :url)

  def short_sha
    sha.to_s[0, 7]
  end

  def message_subject
    message.to_s.lines.first.strip
  end

  def message_body
    message.to_s.sub(/[^\n]*\n*/, '')
  end
end
