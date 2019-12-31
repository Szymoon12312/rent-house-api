# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accommodations do
        member do
          resources :rent_requests, only: [:create]
          get  'rent_requests/:request_id/reject', to: 'rent_requests#reject_request'
          get  'rent_requests/:request_id/cancel', to: 'rent_requests#cancel_request'
          post 'rent_requests/:request_id/accept', to: 'rent_requests#accept_request'
        end
      end
      get 'rent_requests', to: 'rent_requests#index'
      get 'show_pdf', to: 'accommodations#show_pdf'
      resources :groups
      resources :users, only: [:show, :create, :destroy]
      post 'authentication/authenticate'
    end
  end
end
