Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount RailsAdmin::Engine => '/newadmin', as: 'rails_admin'
  namespace :v1, defaults: {format: 'json'} do
    resources :sellers # secure this. as of now :new, :edit work without any authentication
    post 'sellers/exists'
    post 'sellers/sign_in'

    resources :quotations, except: [:new, :edit]
    resources :devices, except: [:new, :edit]
    resources :buyers, except: [:new, :edit]
    resources :quotes, except: [:new, :edit]

    post 'buyers/exists'
    post 'buyers/sign_in'
    post 'quotes/for_seller'
    post 'quotes/for_buyer'

    post 'quotations/for_buyer' => 'quotations#for_buyer'

    get 'brands_categories' => 'brands_categories#index'
    post 'brands_categories' => 'brands_categories#add_category'
    post 'brands_categories/register_seller' => 'brands_categories#assign_to_seller'

  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'welcome#index'
  get 'staging' => 'welcome#staging'

  post '/subscribe' => 'welcome#subscribe'
  post '/contact' => 'welcome#contact'

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "sellers#new", :as => "sign_up"

  get "profile" => "sellers#profile"
  get "categories" => "sellers#categories"
  resources :sellers
  resources :sessions
  resources :visitors
end
