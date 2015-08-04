require 'spec_helper'

describe Portfolio do
  it 'is a value object that holds all portfolio information' do
    Portfolio.new(user: User.new)
  end

  describe '#serialize, .load' do
    it 'can be serialized and reconstructed' do
      portfolio = Portfolio.new(user: User.new(name: 'Flintstone'))
      serialized = portfolio.serialize
      reconstructed = Portfolio.load(serialized)
      expect(reconstructed).to eq reconstructed
    end
  end
end
