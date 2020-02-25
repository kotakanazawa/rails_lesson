# frozen_string_literal: true

Rails.application.routes.draw do
  root "books#index"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  resource :users, only: :show
end
