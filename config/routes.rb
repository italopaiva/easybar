Rails.application.routes.draw do
  root 'sessions#new'

  resources :users
  resources :sessions
  resources :orders
  resources :tables
end
