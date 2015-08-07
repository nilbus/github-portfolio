require 'spec_helper'

describe FetchDataWorker do
  subject(:fetch_data_worker) { described_class.new(github_username) }
  let(:github_username) { 'nilbus' }

  describe '#perform', vcr: {record: :new_episodes} do
    it 'pulls data from GithubAPI, stores it in a PortfolioStore, and returns it' do
      expect_any_instance_of(PortfolioStore).to receive(:save).with Portfolio
      portfolio = fetch_data_worker.perform
      expect(portfolio).to be_a Portfolio
      expect(portfolio.name).to eq 'Edward Anderson'
    end
  end
end
