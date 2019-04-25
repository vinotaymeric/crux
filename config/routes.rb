Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'pages#home'

  resources :trips do
    resources :cities, only: :index do
      resources :trip_activities, only: :show
      put '/trip_activities/:id', to: 'trip_activities#update_trip', as: 'update_trip'
    end
    resources :requests, only: :create
    resources :favorite_itineraries, only: [:create, :destroy]
    resources :messages, only: :create
  end

  resources :itineraries, only: [:show, :index]
  resources :user_activities, only: [:create, :update]
  resources :follows, only: [:create, :destroy, :index]
  resources :invitations, only: :create
end
