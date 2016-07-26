Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  resources :users, only: [:show]
  resources :examinations, except: [:destroy]

  namespace :admin do
    resources :subjects
    resources :users, only: [:index, :show, :destroy]
    resources :questions
  end
  resources :questions
end
