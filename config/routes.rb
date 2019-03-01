Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#home'

  resources :trips
  resources :basecamps_activities, only: [:index, :show]
  resources :itineraries, only: [:show, :index]
  resources :user_activities, only: [:create, :update]
end
