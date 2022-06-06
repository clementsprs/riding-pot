Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  namespace :host do
    resources :rides, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :rides, only: [:show, :index] do
    resources :participations, only: [:create]
    resources :comments, only: [:new, :create, :destroy, :edit, :update]
  end

  resources :participations, only: [:destroy]

  get "/dashboard", to: "users#dashboard"
  get "/components", to: "pages#components"
end
