Rails.application.routes.draw do

  devise_for :users
  root to: 'items#index'
  
  resources :items do
    resources :items, only: [:index, :create, :show, :edit, :update, :destroy]
  end


end
