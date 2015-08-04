require 'spec_helper'

describe GithubAPI do
  describe '#initialize' do
    describe ':token' do
      it 'uses public API access in the absence of an authentication token' do
        GithubAPI.new
      end

      it 'accepts a :token option that it will use for increased API limits' do
        GithubAPI.new(token: '5876794a5b406391a5389c5fdd53f8953633e74c')
      end
    end

    describe ':cache' do
      it 'turns off caching (default on) if given the option cache: false' do
        GithubAPI.new(cache: false)
      end
    end
  end
end
