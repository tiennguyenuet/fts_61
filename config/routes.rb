Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  namespace :admin do
    resources :subjects
  end
end
