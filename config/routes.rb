Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :pieces
  resources :games do
    member do
      patch :join
      put :join
      patch :forfeit
      put :forfeit
    end
  end
  root 'games#index'
end

