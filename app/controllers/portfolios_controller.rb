class PortfoliosController < ApplicationController
  def index
  end

  def show
    @github_username = params[:id]
    @portfolio = PortfolioStore.new.find(@github_username)
    respond_to do |format|
      format.html { render :loading if @portfolio.nil? }
      format.json do
        @portfolio = FetchDataWorker.new.perform(@github_username)
        message = 'reload; portfolio serialization to json not yet supported'
        render json: {result: message}
      end
    end
  end

  # For development: Render a full portfolio with fixture data
  def test
    @portfolio = PortfolioStore.new.find('test')
  end
end
