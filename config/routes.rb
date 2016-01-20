Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'courses#index'

  resources :users, only: [:show]
  resources :courses, only: [:index, :show, :new, :create ]
end
