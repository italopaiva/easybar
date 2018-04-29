Rails.application.routes.draw do
  root 'sessions#new'

  resources :users do
    resources :orders
  end

  resources :checks do
    get '/close', to: "checks#close", on: :member
    get '/remove_tax', to: "checks#remove_tax", on: :member
  end

  resources :sessions
  resources :tables

  resources :admin do
    get '/orders/:order_id/ready', to: 'admin#order_ready', on: :collection, as: 'order_ready'
  end
end
