Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'courses#index'

  resources :users, only: [:show]

  resources :courses do
    resources :lessons, only: [:index, :show, :new, :create, :destroy]
  end

end
