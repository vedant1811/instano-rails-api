Rails.application.routes.draw do

  namespace :v1, defaults: {format: 'json'} do
    resources :sellers # secure this. as of now :new, :edit work without any authentication
    post 'sellers/exists'
    post 'sellers/sign_in'

    resources :quotations, except: [:new, :edit]
    resources :devices, except: [:new, :edit]
    resources :buyers, except: [:new, :edit]
    resources :quotes, except: [:new, :edit]

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

#   get "sellers" => "sellers#index", :as => "sellers_root"

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "sellers#new", :as => "sign_up"
  resources :sellers
  resources :sessions
  resources :visitors

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
