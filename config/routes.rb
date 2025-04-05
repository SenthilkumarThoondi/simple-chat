# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :chats do
    resources :messages
    collection do
      get :new_group
      post :create_group
    end
    member do
      get :new_user
      patch :join_new_user
      patch :remove_user
    end
  end
  get 'new_group_chat', to: 'chats#new_group_chat', as: :new_group_chat
  post 'create_group_chat', to: 'chats#create_group_chat', as: :create_group_chat
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'chats#index'
end
