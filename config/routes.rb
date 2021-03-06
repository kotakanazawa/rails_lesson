# frozen_string_literal: true

Rails.application.routes.draw do
  root "books#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :books, :reports do
    resources :comments
  end

  resources :users do
    resource :follows, only: [:create, :destroy]
    member do
      get :follows, only: :index
      get :followers, only: :index
    end
  end
end
