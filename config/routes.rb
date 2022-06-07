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

  namespace :strava do
    resource :oauth, only: [] do
      collection do
        patch :connect
      end
    end

    resource :oauth_redirect, only: [] do
      collection do
        get :complete_connection
      end
    end
  end

  resources :participations, only: [:destroy]

  get "/dashboard", to: "users#dashboard"
  get "/components", to: "pages#components"
end
