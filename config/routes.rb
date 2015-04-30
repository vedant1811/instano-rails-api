Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount RailsAdmin::Engine => '/newadmin', as: 'rails_admin'
  ActiveAdmin.routes(self)
  namespace :v1, defaults: {format: 'json'} do
    # devies:
    post 'devices' => 'devices#create'
    get 'brands_categories' => 'brands_categories#index'

    scope :sellers do
      post 'exists' => 'sellers#exists'
      post 'sign_in' => 'sellers#sign_in'
      post '' => 'sellers#create'
      match '', to: 'sellers#update', via: [:patch, :put]

      post 'deals' => 'deals#create'
      match 'deals/:id', to: 'deals#update', via: [:patch, :put]

      post 'quotations' => 'quotations#create'
      match 'quotations/:id', to: 'quotations#update', via: [:patch, :put]

#     post 'products' => 'products#create'
    end

    scope :buyers do
      get '' => 'buyers#show'
      post '' => 'buyers#create'
      post 'exists' => 'buyers#exists'
      post 'sign_in' => 'buyers#sign_in'
      match '', to: 'buyers#update', via: [:patch, :put]

      get 'sellers' => 'sellers#index'
      get 'sellers/:id' => 'sellers#show'

      get 'deals' => 'deals#index'
      get 'deals/:id' => 'deals#show'

      get 'quotations' => 'quotations#index'
      get 'quotations/:id' => 'quotations#show'

      get 'quotes' => 'quotes#buyers_index'
      get 'quotes/:id' => 'quotes#show'
      post 'quotes' => 'quotes#create'
      match 'quotes', to: 'quotes#update', via: [:patch, :put]
    end

    get 'products' => 'products#index '
    get 'products/:id' => 'products#show'

#     resources :online_buyers, except: [:new, :edit, :delete]
#     post 'online_buyers/exists'
#     match 'online_buyers', to: 'online_buyers#create', via: [:options, :post]

  end

  root 'welcome#index'

  post '/subscribe' => 'welcome#subscribe'
  post '/contact' => 'welcome#contact'
#
#   get "log_out" => "sessions#destroy", :as => "log_out"
#   get "log_in" => "sessions#new", :as => "log_in"
#   get "sign_up" => "sellers#new", :as => "sign_up"
#
#   get "profile" => "sellers#profile"
#   get "categories" => "sellers#categories"
#   resources :sellers
#   resources :sessions
end
