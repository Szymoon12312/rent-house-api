# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authentication/authenticate'
      post 'users/registration', to: 'users#create'
      get 'accommodations/index'
      get 'accommodations/show/:id',  to: 'accommodations#show'
      post 'accommodations/create'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
