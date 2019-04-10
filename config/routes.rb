Rails.application.routes.draw do
  resources :transactions
  resources :accounts  do
  	get 'check_current_balance', to: 'accounts#check_current_balance'
  	get 'deposit_money', to: 'accounts#deposit_money'
  	patch 'deposit_money', to: 'accounts#deposit_money'
  end
  root to: "accounts#index"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
