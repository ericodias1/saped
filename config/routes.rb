Rails.application.routes.draw do
  resources :orders, except: [:show] do
    get :to_in_progress
    get :to_finished
  end
end
