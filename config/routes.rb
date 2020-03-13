# frozen_string_literal: true

Rails.application.routes.draw do
  root "books#index"
  resources :reports

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  resources :users do
    resource :follows, only: [:create, :destroy]
    member do
      get :follows, only: :index
      get :followers, only: :index
    end
  end
end
