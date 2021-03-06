SampleApp::Application.routes.draw do
  
  get "users/index"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  devise_for :users, :controllers => {
    :registrations => "registrations"
  }
  
  
  resources :users, only: [:show, :index, :destroy] do
    member do
      get :following, :followers
    end
  end
  resources :likes, only: [:create, :destroy]


 devise_for :admin_users, only: [:session, :password], :controllers => {
   sessions:      'admin_users/sessions'
 }
 
  namespace :admin do
    resources :admin_users
    match '/public_on/:id', to: 'microposts#public_on',  via: 'patch', as: 'public_on'
    match '/public_off/:id', to: 'microposts#public_off',  via: 'patch', as: 'public_off'
    resources :microposts, except: [:new, :create, :show]
    resources :users, except: [:new, :create, :show]
  end
 
  
  resources :microposts,    only: [:create, :destroy, :edit, :update]
  
  
  resources :relationships, only: [:create, :destroy]
  resources :contacts,      only: [:new, :create]
  
  

  
  match '/like_on', to: 'likes#like_on',  via: 'post', as: 'like_on'
  match '/like_off/:id', to: 'likes#like_off',  via: 'delete', as: 'like_off'
  

  root  'static_pages#home'
  
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  
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
