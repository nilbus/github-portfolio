Rails.application.routes.draw do
  if (default_portfolio = ENV['PORTFOLIO'])
    root 'portfolios#show', id: default_portfolio
  else
    root 'portfolios#index'
  end
  get '/test', to: 'portfolios#test'
  get '/:id', to: 'portfolios#show'
  get '/:id/reload', to: 'portfolios#reload'
  resources :portfolios, only: %i(index show)
end
