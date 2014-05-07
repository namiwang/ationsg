Ationsg::Application.routes.draw do
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
  devise_for :users, controllers: { omniauth_callbacks: 'authentications' }, skip: [:registrations]
  devise_scope :user do
    # oauth
    get 'users/oauth_bind' => 'oauth_bind#new_from_oauth', as: :oauth_bind_new
    post 'users/oauth_bind' => 'oauth_bind#bind_with_oauth'

    # registration
    get 'users/sign_up' => 'devise/registrations#new', as: :new_user_registration
    post 'users' => 'devise/registrations#create', as: :user_registration
  end

  # products
  resources :products, only: [:show] do
    get 'like' => 'products#like', as: :like
    get 'unlike' => 'products#unlike', as: :unlike
  end

  # categories
  resources :categories, only: [:show]

  # cart
  get 'cart' => 'cart#show', as: :cart
  get 'cart/partial' => 'cart#partial', as: :cart_partial

  # orders
  resources :orders, only: [:new, :create, :show]
  get 'orders/:id/pay' => 'orders#pay', as: :pay_order

  # payments
  resources :payments, only: [:create]
  get 'payments/new/order/:order_id/method/:method' => 'payments#new', as: :new_payment

  # my
  get 'my' => 'my#info'
  get 'my/info' => 'my#info', as: :my_info
  patch 'my/info' => 'my#info_update', as: :udpate_my_info
  get 'my/orders' => 'my#orders', as: :my_orders
  get 'my/addresses' => 'my#addresses', as: :my_addresses
  get 'my/payments' => 'my#payments', as: :my_payments
  get 'my/liked' => 'my#liked', as: :my_liked

  # static pages & root
  get 'pages/home' => 'high_voltage/pages#show', id: 'home'
  root 'high_voltage/pages#show', id: 'home'

end
