class PortfoliosController < ApplicationController
  def index
  end

  def show
    @github_username = params[:id]
    @portfolio = PortfolioStore.new.find(@github_username)
    @branding = Branding.new(branding_params)
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
    PortfolioStore.new.delete(@github_username)
    redirect_to "/#{@github_username}"
  end

  # For development: Render a full portfolio with fixture data
  def test
    @portfolio = PortfolioStore.new.find('test')
    render :show
  end

  private def branding_params
    params.slice(:color)
  end
end
