# frozen_string_literal: true

class PortfoliosController < ApplicationController
  caches_page :index, :show

  def index; end

  def show
    @github_username = params[:id]
    @portfolio = PortfolioStore.new.find(@github_username)
    respond_to do |format|
      format.html { render :loading if @portfolio.nil? }
      format.json { reload_portfolio(@github_username) }
    end
  end

  def reload
    @github_username = params[:id]
    render :loading
  end

  private

  def reload_portfolio(github_username)
    @portfolio = FetchDataWorker.new(github_username).perform
    expire_page_cache(github_username)
    message = 'reload; portfolio serialization to json not yet supported'
    render json: {result: message}
  end

  def expire_page_cache(github_username)
    expire_page "/#{github_username}"
    expire_page '/' if github_username == ENV['PORTFOLIO']
  end
end
