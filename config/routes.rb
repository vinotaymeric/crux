Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  root to: 'pages#home'
=======

  root to: 'pages#home'

  resources :itineraries, only: [:index, :show] do
    resources :trips, only: [:new, :create]
  end

  resources :trips, only: [:show, :index, :edit, :update]


>>>>>>> 530b807c5d270e32949fce3a6a615e843563cf0e
end
