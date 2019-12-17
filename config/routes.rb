Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :games do
    member do
      patch :join
      put :join
    end
  end
  root 'games#index'
end

