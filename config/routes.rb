Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'courses#index'

  resources :users, only: [:show, :index]

  resources :courses do
    resources :lessons
  end

  resources :enrollments, only: [:new, :create, :index, :destroy, :show]

  resources :questions, only: [:index, :create, :new, :edit, :destroy, :update] do
    resources :answers
  end

  resources :texts, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:destroy]
      resources :enrollments, only: [:destroy]
      resources :lessons, only: [:update]
    end
  end
end
