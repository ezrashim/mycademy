Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'courses#index'

  resources :users, only: [:show]

  resources :courses do
    resources :lessons
  end

  resources :enrollments, only: [:new, :create, :index, :destroy]

  resources :questions, only: [:index, :create, :new, :show]
end
