Rails.application.routes.draw do
  root 'portfolios#index'
  get '/:id', to: 'portfolios#show'
  resources :portfolios, only: %i(index show)
end
