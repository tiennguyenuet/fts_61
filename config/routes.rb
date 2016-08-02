Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :users, only: [:show]
  resources :examinations, except: [:destroy]

  namespace :admin do
    resources :subjects
    resources :users, only: [:index, :update]
    resources :questions
    resources :examinations, only: [:index, :show, :update]
  end
  resources :questions
end
