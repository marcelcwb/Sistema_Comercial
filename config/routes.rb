Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  resources :users, except: %i[show]
  resources :customers
  resources :products do
    resources :stock_movements, only: %i[new create]
  end
  resources :orders
  resources :financial_entries
end
