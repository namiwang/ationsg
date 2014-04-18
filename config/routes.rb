Ationsg::Application.routes.draw do
  get "products/show"
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

  # admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # devise
  devise_for :users, :controllers => { :omniauth_callbacks => "authentications" }

  devise_scope :user do
    get 'users/oauth_bind' => 'oauth_bind#new_from_oauth', as: :oauth_bind_new
    post 'users/oauth_bind' => 'oauth_bind#bind_with_oauth'
  end

  # products
  resources :products, only: [:show]

  # categories
  resources :categories, only: [:show]

  # cart
  get 'cart' => 'cart#show', as: :cart_show
  get 'cart/partial' => 'cart#partial', as: :cart_partial

  # static pages & root
  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
  root 'high_voltage/pages#show', id: 'home'

end
