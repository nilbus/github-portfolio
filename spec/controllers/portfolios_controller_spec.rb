require 'rails_helper'

RSpec.describe PortfoliosController, type: :controller do
  render_views

  it "loads without error, showing the user's name" do
    get :show, id: 'nilbus'
    expect(response.body).to include 'Edward Anderson'
  end
end
