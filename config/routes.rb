Rails.application.routes.draw do
  devise_for :users
  root 'orders#index'
  resources :orders, except: [:show] do
    get :to_in_progress
    get :to_finished
  end
end
