Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'pages#home'

  # resources :trips, only: [:edit, :update] do
    resources :basecamps, only: [:index, :show] do
      resources :itineraries, only: [:index, :show]
    end
  # end

  resources :trips, only: [:show, :index, :new, :create]
end
