require 'spec_helper'

describe FetchDataWorker do
  let(:github_username) { 'nilbus' }

  describe '#perform', :vcr do
    it 'pulls data from GithubAPI, stores it in a PortfolioStore, and returns it' do
      expect_any_instance_of(PortfolioStore).to receive(:save).with Portfolio
      portfolio = subject.perform(github_username)
      expect(portfolio).to be_a Portfolio
      expect(portfolio.name).to eq 'Edward Anderson'
    end
  end
end
