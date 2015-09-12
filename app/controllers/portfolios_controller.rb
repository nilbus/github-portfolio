class PortfoliosController < ApplicationController
  def index
  end

  def show
    @github_username = params[:id]
    @portfolio = PortfolioStore.new.find(@github_username)
    respond_to do |format|
      format.html { render :loading if @portfolio.nil? }
      format.json do
        @portfolio = FetchDataWorker.new(@github_username).perform
        message = 'reload; portfolio serialization to json not yet supported'
        render json: {result: message}
      end
    end
  end

  def reload
    @github_username = params[:id]
    render :loading
  end
end
