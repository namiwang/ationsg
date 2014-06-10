Ationsg::Application.routes.draw do

  scope "(:locale)", locale: /en|zh-CN/ do
    # devise
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

    resources :comments, only: [:show, :new, :create]

    # categories
    resources :categories, only: [:show]

    # cart
    get 'cart' => 'cart#show', as: :cart
    get 'cart/partial' => 'cart#partial', as: :cart_partial

    # orders
    resources :orders, only: [:new, :create, :show]
    get 'orders/:id/pay' => 'orders#pay', as: :pay_order

    # payments
    # resources :payments, only: [:create]
    get 'payments/new/order/:order_id/method/:method' => 'payments#create', as: :create_payment

    # cards
    get 'cards/:card_id/recharge' => 'recharge_payments#new', as: :recharge_card
    resources :recharge_payments, only: [:new, :create]

    # my
    get 'my' => 'my#info'
    get 'my/info' => 'my#info', as: :my_info
    patch 'my/info' => 'my#info_update', as: :udpate_my_info
    get 'my/orders' => 'my#orders', as: :my_orders
    get 'my/addresses' => 'my#addresses', as: :my_addresses
    get 'my/payments' => 'my#payments', as: :my_payments
    get 'my/liked' => 'my#liked', as: :my_liked
    get 'my/comments' => 'my#comments', as: :my_comments
    get 'my/cards' => 'my#cards', as: :my_cards

    # static pages & root
    resources :pages, only: [:show]

  end

  # admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # omniauth doesnot support dynamic routing with locale
  devise_for :users, controllers: { omniauth_callbacks: 'authentications' }, skip: [:registrations]

  get "/:locale" => 'pages#show', id: 'home'
  root 'pages#show', id: 'home'  

end
