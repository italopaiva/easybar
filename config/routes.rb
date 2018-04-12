Rails.application.routes.draw do
  root 'sessions#new'

  resources :users do
    resources :orders
  end

  resources :sessions
  resources :tables
end
