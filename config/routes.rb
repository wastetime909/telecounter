Rails.application.routes.draw do

  root 'pages#home'
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
  post 'scanner/scan_result'

  # get 'basic-qr-code-reader', to: 'basic_qr_codes#index'
  get 'scanner/index'
  # get 'basic_qr_codes/index'

  get '/service-worker.js', to: 'service_workers/workers#index'
  get '/manifest.json', to: 'service_workers/manifests#index'
  get '/offline.html', to: 'service_workers/workers#offline'

  resources :headcounts do 
    member do 
      
    end
  end
end
