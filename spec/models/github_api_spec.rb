require 'spec_helper'

describe GithubAPI do
  describe '#initialize' do
    describe ':token' do
      it 'uses public API access in the absence of an authentication token' do
        GithubAPI.new(github_username: 'test')
      end

      it 'accepts a :token option that it will use for increased API limits' do
        GithubAPI.new(github_username: 'test', token: '5876794a5b406391a5389c5fdd53f8953633e74c')
      end
    end

    describe ':cache' do
      it 'turns off caching (default on) if given the option cache: false' do
        GithubAPI.new(github_username: 'test', cache: false)
      end
    end
  end
end
