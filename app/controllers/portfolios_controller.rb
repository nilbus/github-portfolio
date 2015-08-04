class PortfoliosController < ApplicationController
  def index
  end

  def show
    @github_username = params[:id]
    @portfolio = PortfolioStore.new.find(@github_username)
    respond_to do |format|
      format.html do
        return render :loading if @portfolio.nil?
      end
      format.json do
        @portfolio = FetchDataWorker.new.perform(@github_username)
        render json: {result: 'reload; portfolio serialization to json not yet supported'}
      end
    end
  end
end
