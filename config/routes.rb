Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  post 'home/add_account_balance'
  post 'home/add_user_expense'

  resources :expenses
  resources :transactions do
    collection do
      get 'filter_transaction'
      post 'update_status'
    end
  end


end
