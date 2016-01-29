Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'courses#landing'

  resources :users, only: [:show]

  resources :courses do
    resources :lessons
  end

  resources :enrollments, only: [:new, :create, :index, :destroy, :show]

  resources :questions, only: [:index, :create, :new, :edit, :destroy, :update] do
    resources :answers
  end

  get "/landing" => "courses#landing"
end
