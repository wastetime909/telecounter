Rails.application.routes.draw do

  root 'pages#my_counters'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users,
  path:'',
  path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
  controllers: {sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations'}
  get 'cart_items/member_cart'

  get 'headcounts/new_entrance'
  get 'headcounts/new_exit'
  get 'pages/my_counters'
  get 'pages/user_page'
  get 'pages/admin_page'


  resources :headcounts do 
    member do 
      
    end
  end
end
