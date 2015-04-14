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
      post 'quotations' => 'sellers#quotations_create'
      match 'quotations/:id', to: 'sellers#quotations_update', via: [:patch, :put]
      get 'quotes' => 'sellers#quotes'
    end

    scope :buyers do
      get '' => 'buyers#show'
      post '' => 'buyers#create'
      post 'exists' => 'buyers#exists'
      post 'sign_in' => 'buyers#sign_in'
      match '', to: 'buyers#update', via: [:patch, :put]
      get 'sellers' => 'buyers#sellers_index'
      get 'sellers/:id' => 'buyers#sellers_show'
      get 'deals' => 'buyers#deals_index'
      get 'deals/:id' => 'buyers#deals_show'
      get 'quotations' => 'buyers#quotations'
      get 'quotes' => 'buyers#quotes'
      post 'quotes' => 'buyers#quotes_create'
      match 'quotes', to: 'buyers#quotes_update', via: [:patch, :put]
    end

#     post 'products' => 'products#create'

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
