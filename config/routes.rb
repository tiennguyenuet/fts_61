Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  resources :examinations, except: [:destroy]

  namespace :admin do
    resources :subjects
    resources :users, only: [:index, :show, :destroy]
    resources :questions
  end
end
