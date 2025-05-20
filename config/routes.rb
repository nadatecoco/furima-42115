Rails.application.routes.draw do
  get 'buyers/index'
  get 'buyers/create'

  devise_for :users
  root to: 'items#index'
  
  resources :items do
    resources :items, only: [:index, :create, :show, :edit, :update, :destroy]
    resources :buyers, only: [:index, :create]
  end
end
