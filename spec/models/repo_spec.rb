require 'spec_helper'

describe Repo do
  describe '.group_by_ownership' do
    it 'returns 2 arrays: [[owned_repos], [other_repos]]' do
      owner = User.new(login: 'owner')
      other = User.new(login: 'not me')
      owned_repo = ->{ Repo.new(querying_user: owner, owner: owner, full_name: "#{owner.login}/repo") }
      other_repo = ->{ Repo.new(querying_user: owner, owner: other, full_name: "#{owner.login}/repo") }
      repos = [owned_repo.(), other_repo.()]
      expect(Repo.group_by_ownership(repos)).to eq [[owned_repo.()], [other_repo.()]]
    end

    it 'returns blank arrays for owned or other sets that are empty' do
      owner = User.new(login: 'owner')
      other = User.new(login: 'not me')
      other_repo = ->{ Repo.new(querying_user: owner, owner: other, full_name: "#{owner.login}/repo") }
      repos = [other_repo.()]
      expect(Repo.group_by_ownership(repos)).to eq [[], [other_repo.()]]
    end
  end
end
