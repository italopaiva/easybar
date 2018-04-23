Rails.application.routes.draw do
  root 'sessions#new'

  resources :users do
    resources :orders
  end

  resources :checks

  resources :sessions
  resources :tables

  resources :admin do
    get '/orders/:order_id/ready', to: 'admin#order_ready', on: :collection, as: 'order_ready'
  end
end
