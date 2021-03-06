Rails.application.routes.draw do

  root 'static_pages#home'

  # devise_for :users
  devise_for :users, path: "user", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', registration: 'register', edit: 'your_account', sign_up: 'cmon_let_me_in' }
  
  # Users
  resources :users, except: :index

  # Boxes
  get "boxes/checkout" => "boxes#checkout"
  resources :boxes, except: [:index, :update, :create, :new]
  post 'boxes/create' => "boxes#create"


  # Products
  resources :products, only: [:index, :new]
  get "products/filter" => "products#filter"
  post "products/show" => "products#show"


  # API
  namespace :api do
    get 'boxes/index' => 'boxes#index', defaults: { format: "json"}
    get 'boxes/show'  => 'boxes#show', defaults: { format: "json"}
    get 'boxes/show_first_ten'  => 'boxes#show_first_ten', defaults: { format: "json"}
  end

  #Stripe Resources
  resources :charges


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
