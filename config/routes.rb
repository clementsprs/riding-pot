Rails.application.routes.draw do
  # get 'users/dashboard'
  devise_for :users
  root to: 'pages#home'

  namespace :host do
    resources :rides, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :rides, only: [:show, :index] do
    resources :participations, only: [:create]
  end

  resources :participations, only: [:destroy]

  get "/dashboard", to: "users#dashboard"
end
