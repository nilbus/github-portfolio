require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  render_views

  it "shows a loading screen when there is no data for the requested user" do
    github_username = 'unseen_user'
    get :show, id: github_username
    expect(response.body).to match /wait|load|fetch|get/i
    expect(response.body).to include github_username
  end

  it "shows the user's name if the data is available" do
    get :show, id: 'test'
    expect(response.body).to include 'test'
  end
end
