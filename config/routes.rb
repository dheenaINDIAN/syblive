Zatfish::Application.routes.draw do
  get "home/dashboard"
  match "/home/create_user_profile"=> "home#create_user_profile",:as=>'user_profile'
  match "/home/new_user_profile"=> "home#new_user_profile"
  #devise_for :users
  match '/auth/:provider/callback'  => 'authorization#create'
  match '/auth/failure'             => 'authorization#failure'
  match 'home/csv' => 'home#csv', :via => :post
  match 'home/csvupload' => 'home#csvupload', :via => :get
  match 'home/categorylist/:id' => 'home#categorylist'
  match '/chart/:id' => 'home#chart'
  match 'admin_page'  => 'home#admin_page'
  match 'home/dashboard' => 'home#dashboard'
  match 'new_user'  => 'home#new_user'
  match 'create_user'  => 'home#create_user'
  match 'index'  => 'home#index'
  match 'login'  => 'api#login'
  match 'category'  => 'api#category'
  match 'new'  => 'api#new'
 

  devise_for :users, :controllers => {:registrations => "devise/registrations"}

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'home#dashboard'
  
   root :to => 'home#index'
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
