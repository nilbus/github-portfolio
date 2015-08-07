require 'spec_helper'

describe Version do
  describe '#to_s' do
    it 'returns the version tag without the leading v' do
      expect(Version.new(name: 'v1.0.0').to_s).to eq '1.0.0'
    end
  end

  describe '#age' do
    it 'expresses the age in words' do
      expect(Version.new(date: 3.hours.ago).age).to match /3 hours/
    end
  end
end
