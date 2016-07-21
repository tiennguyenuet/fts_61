Rails.application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}
  root "static_pages#home"

  resources :examinations, except: [:destroy]

  namespace :admin do
    resources :subjects
    resources :users, only: [:index, :show, :destroy]
  end
end
