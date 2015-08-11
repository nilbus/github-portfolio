require 'spec_helper'

describe UserRole do
  context 'with casual stats' do
    let(:casual_stats) {
      instance_double(Stats,
        commit_count_user: 1,
        commit_count_total: 100,
        commits_authored_percentage: 1,
        contribution_rank_by_commits: 100,
        total_contributors: 100,
        tier: 100,
      )
    }

    it 'reports "Casual Contributor"' do
      expect(UserRole.new(casual_stats).to_s).to match /casual/i
    end
  end

  context 'with top tier stats' do
    let(:top_tier_stats) {
      instance_double(Stats,
        commit_count_user: 9,
        commit_count_total: 100,
        commits_authored_percentage: 9,
        contribution_rank_by_commits: 4,
        total_contributors: 100,
        tier: 5,
      )
    }

    it 'reports "Top 5 Contributor"' do
      expect(UserRole.new(top_tier_stats).to_s).to match /top/i
      expect(UserRole.new(top_tier_stats).to_s).to include '5'
    end
  end
end
