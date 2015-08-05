require 'spec_helper'

describe Commit do
  let(:multiline_message) {
    <<-MSG
subject

body after a blank line
    MSG
  }

  describe '#message_subject' do
    it "returns the message's first line, with no newline" do
      commit = Commit.new(message: multiline_message)
      expect(commit.message_subject).to eq 'subject'
    end
  end

  describe '#message_body' do
    it 'returns the body of the message, without the subject' do
      commit = Commit.new(message: multiline_message)
      expect(commit.message_body).to eq "body after a blank line\n"
    end

    it 'returns an empty string when the commit message is only 1 line' do
      commit = Commit.new(message: 'oneline')
      expect(commit.message_body).to eq ''
    end
  end

  describe '#short_sha' do
    it 'returns the first 7 characters of the sha' do
      commit = Commit.new(sha: '6d1ad5f65777a59b73b09bf34cc06b0c1fec5998')
      expect(commit.short_sha).to eq '6d1ad5f'
    end
  end
end
