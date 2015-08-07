require 'spec_helper'

describe Stats do
  subject(:stats) { Stats.new(user: user, contribution_stats_response: response) }

  context 'with no user or response given' do
    let(:user) { nil }
    let(:response) { nil }

    describe '#commit_count_user' do
      subject { stats.commit_count_user }
      it { is_expected.to eq 0 }
    end

    describe '#commit_count_total' do
      subject { stats.commit_count_total }
      it { is_expected.to eq 0 }
    end

    describe '#addition_count_user' do
      subject { stats.addition_count_user }
      it { is_expected.to eq 0 }
    end

    describe '#addition_count_total' do
      subject { stats.addition_count_total }
      it { is_expected.to eq 0 }
    end
  end

  context 'with a real response' do
    describe '#commit_count_user' do
      subject { stats.commit_count_user }
      it { is_expected.to eq 142 }
    end

    describe '#commit_count_total' do
      subject { stats.commit_count_total }
      it { is_expected.to eq 205 }
    end

    describe '#addition_count_user' do
      subject { stats.addition_count_user }
      it { is_expected.to eq 4252 }
    end

    describe '#addition_count_total' do
      subject { stats.addition_count_total }
      it { is_expected.to eq 7066 }
    end

    context 'with no user given' do
      let(:user) { nil }

      describe '#commit_count_user' do
        subject { stats.commit_count_user }
        it { is_expected.to eq 0 }
      end

      describe '#commit_count_total' do
        subject { stats.commit_count_total }
        it { is_expected.to eq 205 }
      end

      describe '#addition_count_user' do
        subject { stats.addition_count_user }
        it { is_expected.to eq 0 }
      end

      describe '#addition_count_total' do
        subject { stats.addition_count_total }
        it { is_expected.to eq 7066 }
      end
    end

    let(:user) { User.new(login: 'nilbus') }
    let(:response) do
       [{:total=>6,
       :weeks=>
        [{:w=>1421539200, :a=>0, :d=>0, :c=>0},
         {:w=>1422144000, :a=>0, :d=>0, :c=>0},
         {:w=>1422748800, :a=>0, :d=>0, :c=>0},
         {:w=>1423353600, :a=>0, :d=>0, :c=>0},
         {:w=>1423958400, :a=>0, :d=>0, :c=>0},
         {:w=>1424563200, :a=>0, :d=>0, :c=>0},
         {:w=>1425168000, :a=>0, :d=>0, :c=>0},
         {:w=>1425772800, :a=>0, :d=>0, :c=>0},
         {:w=>1426377600, :a=>0, :d=>0, :c=>0},
         {:w=>1426982400, :a=>0, :d=>0, :c=>0},
         {:w=>1427587200, :a=>0, :d=>0, :c=>0},
         {:w=>1428192000, :a=>171, :d=>78, :c=>6},
         {:w=>1428796800, :a=>0, :d=>0, :c=>0},
         {:w=>1429401600, :a=>0, :d=>0, :c=>0},
         {:w=>1430006400, :a=>0, :d=>0, :c=>0},
         {:w=>1430611200, :a=>0, :d=>0, :c=>0},
         {:w=>1431216000, :a=>0, :d=>0, :c=>0},
         {:w=>1431820800, :a=>0, :d=>0, :c=>0},
         {:w=>1432425600, :a=>0, :d=>0, :c=>0},
         {:w=>1433030400, :a=>0, :d=>0, :c=>0},
         {:w=>1433635200, :a=>0, :d=>0, :c=>0},
         {:w=>1434240000, :a=>0, :d=>0, :c=>0},
         {:w=>1434844800, :a=>0, :d=>0, :c=>0},
         {:w=>1435449600, :a=>0, :d=>0, :c=>0},
         {:w=>1436054400, :a=>0, :d=>0, :c=>0},
         {:w=>1436659200, :a=>0, :d=>0, :c=>0},
         {:w=>1437264000, :a=>0, :d=>0, :c=>0},
         {:w=>1437868800, :a=>0, :d=>0, :c=>0},
         {:w=>1438473600, :a=>0, :d=>0, :c=>0}],
       :author=>
        {:login=>"mwytock0812",
         :id=>6833973,
         :avatar_url=>"https://avatars.githubusercontent.com/u/6833973?v=3",
         :gravatar_id=>"",
         :url=>"https://api.github.com/users/mwytock0812",
         :html_url=>"https://github.com/mwytock0812",
         :followers_url=>"https://api.github.com/users/mwytock0812/followers",
         :following_url=>
          "https://api.github.com/users/mwytock0812/following{/other_user}",
         :gists_url=>"https://api.github.com/users/mwytock0812/gists{/gist_id}",
         :starred_url=>
          "https://api.github.com/users/mwytock0812/starred{/owner}{/repo}",
         :subscriptions_url=>
          "https://api.github.com/users/mwytock0812/subscriptions",
         :organizations_url=>"https://api.github.com/users/mwytock0812/orgs",
         :repos_url=>"https://api.github.com/users/mwytock0812/repos",
         :events_url=>"https://api.github.com/users/mwytock0812/events{/privacy}",
         :received_events_url=>
          "https://api.github.com/users/mwytock0812/received_events",
         :type=>"User",
         :site_admin=>false}},
       {:total=>6,
       :weeks=>
        [{:w=>1421539200, :a=>0, :d=>0, :c=>0},
         {:w=>1422144000, :a=>0, :d=>0, :c=>0},
         {:w=>1422748800, :a=>0, :d=>0, :c=>0},
         {:w=>1423353600, :a=>0, :d=>0, :c=>0},
         {:w=>1423958400, :a=>0, :d=>0, :c=>0},
         {:w=>1424563200, :a=>0, :d=>0, :c=>0},
         {:w=>1425168000, :a=>0, :d=>0, :c=>0},
         {:w=>1425772800, :a=>0, :d=>0, :c=>0},
         {:w=>1426377600, :a=>23, :d=>3, :c=>2},
         {:w=>1426982400, :a=>0, :d=>0, :c=>0},
         {:w=>1427587200, :a=>0, :d=>0, :c=>0},
         {:w=>1428192000, :a=>0, :d=>0, :c=>0},
         {:w=>1428796800, :a=>13, :d=>29, :c=>4},
         {:w=>1429401600, :a=>0, :d=>0, :c=>0},
         {:w=>1430006400, :a=>0, :d=>0, :c=>0},
         {:w=>1430611200, :a=>0, :d=>0, :c=>0},
         {:w=>1431216000, :a=>0, :d=>0, :c=>0},
         {:w=>1431820800, :a=>0, :d=>0, :c=>0},
         {:w=>1432425600, :a=>0, :d=>0, :c=>0},
         {:w=>1433030400, :a=>0, :d=>0, :c=>0},
         {:w=>1433635200, :a=>0, :d=>0, :c=>0},
         {:w=>1434240000, :a=>0, :d=>0, :c=>0},
         {:w=>1434844800, :a=>0, :d=>0, :c=>0},
         {:w=>1435449600, :a=>0, :d=>0, :c=>0},
         {:w=>1436054400, :a=>0, :d=>0, :c=>0},
         {:w=>1436659200, :a=>0, :d=>0, :c=>0},
         {:w=>1437264000, :a=>0, :d=>0, :c=>0},
         {:w=>1437868800, :a=>0, :d=>0, :c=>0},
         {:w=>1438473600, :a=>0, :d=>0, :c=>0}],
       :author=>
        {:login=>"JYoung217",
         :id=>6853912,
         :avatar_url=>"https://avatars.githubusercontent.com/u/6853912?v=3",
         :gravatar_id=>"",
         :url=>"https://api.github.com/users/JYoung217",
         :html_url=>"https://github.com/JYoung217",
         :followers_url=>"https://api.github.com/users/JYoung217/followers",
         :following_url=>
          "https://api.github.com/users/JYoung217/following{/other_user}",
         :gists_url=>"https://api.github.com/users/JYoung217/gists{/gist_id}",
         :starred_url=>
          "https://api.github.com/users/JYoung217/starred{/owner}{/repo}",
         :subscriptions_url=>"https://api.github.com/users/JYoung217/subscriptions",
         :organizations_url=>"https://api.github.com/users/JYoung217/orgs",
         :repos_url=>"https://api.github.com/users/JYoung217/repos",
         :events_url=>"https://api.github.com/users/JYoung217/events{/privacy}",
         :received_events_url=>
          "https://api.github.com/users/JYoung217/received_events",
         :type=>"User",
         :site_admin=>false}},
       {:total=>13,
       :weeks=>
        [{:w=>1421539200, :a=>0, :d=>0, :c=>0},
         {:w=>1422144000, :a=>0, :d=>0, :c=>0},
         {:w=>1422748800, :a=>0, :d=>0, :c=>0},
         {:w=>1423353600, :a=>0, :d=>0, :c=>0},
         {:w=>1423958400, :a=>0, :d=>0, :c=>0},
         {:w=>1424563200, :a=>103, :d=>12, :c=>3},
         {:w=>1425168000, :a=>0, :d=>0, :c=>0},
         {:w=>1425772800, :a=>15, :d=>13, :c=>2},
         {:w=>1426377600, :a=>370, :d=>135, :c=>5},
         {:w=>1426982400, :a=>0, :d=>0, :c=>0},
         {:w=>1427587200, :a=>0, :d=>0, :c=>0},
         {:w=>1428192000, :a=>109, :d=>40, :c=>1},
         {:w=>1428796800, :a=>5, :d=>2, :c=>2},
         {:w=>1429401600, :a=>0, :d=>0, :c=>0},
         {:w=>1430006400, :a=>0, :d=>0, :c=>0},
         {:w=>1430611200, :a=>0, :d=>0, :c=>0},
         {:w=>1431216000, :a=>0, :d=>0, :c=>0},
         {:w=>1431820800, :a=>0, :d=>0, :c=>0},
         {:w=>1432425600, :a=>0, :d=>0, :c=>0},
         {:w=>1433030400, :a=>0, :d=>0, :c=>0},
         {:w=>1433635200, :a=>0, :d=>0, :c=>0},
         {:w=>1434240000, :a=>0, :d=>0, :c=>0},
         {:w=>1434844800, :a=>0, :d=>0, :c=>0},
         {:w=>1435449600, :a=>0, :d=>0, :c=>0},
         {:w=>1436054400, :a=>0, :d=>0, :c=>0},
         {:w=>1436659200, :a=>0, :d=>0, :c=>0},
         {:w=>1437264000, :a=>0, :d=>0, :c=>0},
         {:w=>1437868800, :a=>0, :d=>0, :c=>0},
         {:w=>1438473600, :a=>0, :d=>0, :c=>0}],
       :author=>
        {:login=>"corey-f",
         :id=>10466415,
         :avatar_url=>"https://avatars.githubusercontent.com/u/10466415?v=3",
         :gravatar_id=>"",
         :url=>"https://api.github.com/users/corey-f",
         :html_url=>"https://github.com/corey-f",
         :followers_url=>"https://api.github.com/users/corey-f/followers",
         :following_url=>
          "https://api.github.com/users/corey-f/following{/other_user}",
         :gists_url=>"https://api.github.com/users/corey-f/gists{/gist_id}",
         :starred_url=>"https://api.github.com/users/corey-f/starred{/owner}{/repo}",
         :subscriptions_url=>"https://api.github.com/users/corey-f/subscriptions",
         :organizations_url=>"https://api.github.com/users/corey-f/orgs",
         :repos_url=>"https://api.github.com/users/corey-f/repos",
         :events_url=>"https://api.github.com/users/corey-f/events{/privacy}",
         :received_events_url=>
          "https://api.github.com/users/corey-f/received_events",
         :type=>"User",
         :site_admin=>false}},
       {:total=>38,
       :weeks=>
        [{:w=>1421539200, :a=>0, :d=>0, :c=>0},
         {:w=>1422144000, :a=>0, :d=>0, :c=>0},
         {:w=>1422748800, :a=>3, :d=>3, :c=>1},
         {:w=>1423353600, :a=>0, :d=>0, :c=>0},
         {:w=>1423958400, :a=>105, :d=>29, :c=>2},
         {:w=>1424563200, :a=>0, :d=>0, :c=>0},
         {:w=>1425168000, :a=>79, :d=>0, :c=>1},
         {:w=>1425772800, :a=>176, :d=>63, :c=>1},
         {:w=>1426377600, :a=>128, :d=>67, :c=>8},
         {:w=>1426982400, :a=>346, :d=>129, :c=>10},
         {:w=>1427587200, :a=>1002, :d=>198, :c=>8},
         {:w=>1428192000, :a=>0, :d=>0, :c=>0},
         {:w=>1428796800, :a=>166, :d=>76, :c=>7},
         {:w=>1429401600, :a=>0, :d=>0, :c=>0},
         {:w=>1430006400, :a=>0, :d=>0, :c=>0},
         {:w=>1430611200, :a=>0, :d=>0, :c=>0},
         {:w=>1431216000, :a=>0, :d=>0, :c=>0},
         {:w=>1431820800, :a=>0, :d=>0, :c=>0},
         {:w=>1432425600, :a=>0, :d=>0, :c=>0},
         {:w=>1433030400, :a=>0, :d=>0, :c=>0},
         {:w=>1433635200, :a=>0, :d=>0, :c=>0},
         {:w=>1434240000, :a=>0, :d=>0, :c=>0},
         {:w=>1434844800, :a=>0, :d=>0, :c=>0},
         {:w=>1435449600, :a=>0, :d=>0, :c=>0},
         {:w=>1436054400, :a=>0, :d=>0, :c=>0},
         {:w=>1436659200, :a=>0, :d=>0, :c=>0},
         {:w=>1437264000, :a=>0, :d=>0, :c=>0},
         {:w=>1437868800, :a=>0, :d=>0, :c=>0},
         {:w=>1438473600, :a=>0, :d=>0, :c=>0}],
       :author=>
        {:login=>"kylejmcintyre",
         :id=>4512670,
         :avatar_url=>"https://avatars.githubusercontent.com/u/4512670?v=3",
         :gravatar_id=>"",
         :url=>"https://api.github.com/users/kylejmcintyre",
         :html_url=>"https://github.com/kylejmcintyre",
         :followers_url=>"https://api.github.com/users/kylejmcintyre/followers",
         :following_url=>
          "https://api.github.com/users/kylejmcintyre/following{/other_user}",
         :gists_url=>"https://api.github.com/users/kylejmcintyre/gists{/gist_id}",
         :starred_url=>
          "https://api.github.com/users/kylejmcintyre/starred{/owner}{/repo}",
         :subscriptions_url=>
          "https://api.github.com/users/kylejmcintyre/subscriptions",
         :organizations_url=>"https://api.github.com/users/kylejmcintyre/orgs",
         :repos_url=>"https://api.github.com/users/kylejmcintyre/repos",
         :events_url=>"https://api.github.com/users/kylejmcintyre/events{/privacy}",
         :received_events_url=>
          "https://api.github.com/users/kylejmcintyre/received_events",
         :type=>"User",
         :site_admin=>false}},
       {:total=>142,
       :weeks=>
        [{:w=>1421539200, :a=>1041, :d=>41, :c=>6},
         {:w=>1422144000, :a=>44, :d=>12, :c=>5},
         {:w=>1422748800, :a=>236, :d=>12, :c=>6},
         {:w=>1423353600, :a=>41, :d=>7, :c=>1},
         {:w=>1423958400, :a=>591, :d=>80, :c=>13},
         {:w=>1424563200, :a=>11, :d=>11, :c=>4},
         {:w=>1425168000, :a=>70, :d=>19, :c=>2},
         {:w=>1425772800, :a=>42, :d=>0, :c=>2},
         {:w=>1426377600, :a=>84, :d=>107, :c=>13},
         {:w=>1426982400, :a=>10, :d=>3, :c=>2},
         {:w=>1427587200, :a=>725, :d=>694, :c=>18},
         {:w=>1428192000, :a=>264, :d=>108, :c=>19},
         {:w=>1428796800, :a=>41, :d=>4, :c=>5},
         {:w=>1429401600, :a=>78, :d=>44, :c=>14},
         {:w=>1430006400, :a=>5, :d=>2, :c=>1},
         {:w=>1430611200, :a=>0, :d=>0, :c=>0},
         {:w=>1431216000, :a=>0, :d=>0, :c=>0},
         {:w=>1431820800, :a=>0, :d=>0, :c=>0},
         {:w=>1432425600, :a=>0, :d=>0, :c=>0},
         {:w=>1433030400, :a=>0, :d=>0, :c=>0},
         {:w=>1433635200, :a=>0, :d=>0, :c=>0},
         {:w=>1434240000, :a=>0, :d=>0, :c=>0},
         {:w=>1434844800, :a=>0, :d=>0, :c=>0},
         {:w=>1435449600, :a=>0, :d=>0, :c=>0},
         {:w=>1436054400, :a=>969, :d=>931, :c=>31},
         {:w=>1436659200, :a=>0, :d=>0, :c=>0},
         {:w=>1437264000, :a=>0, :d=>0, :c=>0},
         {:w=>1437868800, :a=>0, :d=>0, :c=>0},
         {:w=>1438473600, :a=>0, :d=>0, :c=>0}],
       :author=>
        {:login=>"nilbus",
         :id=>64751,
         :avatar_url=>"https://avatars.githubusercontent.com/u/64751?v=3",
         :gravatar_id=>"",
         :url=>"https://api.github.com/users/nilbus",
         :html_url=>"https://github.com/nilbus",
         :followers_url=>"https://api.github.com/users/nilbus/followers",
         :following_url=>
          "https://api.github.com/users/nilbus/following{/other_user}",
         :gists_url=>"https://api.github.com/users/nilbus/gists{/gist_id}",
         :starred_url=>"https://api.github.com/users/nilbus/starred{/owner}{/repo}",
         :subscriptions_url=>"https://api.github.com/users/nilbus/subscriptions",
         :organizations_url=>"https://api.github.com/users/nilbus/orgs",
         :repos_url=>"https://api.github.com/users/nilbus/repos",
         :events_url=>"https://api.github.com/users/nilbus/events{/privacy}",
         :received_events_url=>"https://api.github.com/users/nilbus/received_events",
         :type=>"User",
         :site_admin=>false}}
      ]
    end
  end
end
