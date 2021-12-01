Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  devise_scope :user do
    namespace :admin do
      resources :products
      resources :users
      resources :categories
      resources :coupons
      resources :orders
    end

    namespace :api do
      namespace :v1 do
        resources :products
      end
    end

    resources :users
    resources :products
    resources :cart_price
    resources :cart_items do
      collection do
        post :update_quantity
      end
    end
    resources :states, only: :index
    resources :cities, only: :index
    resources :orders
    resources :checkouts do
      member do
        get :add_order_info
        get :confirm_order
      end
    end

    root 'devise/sessions#new'
  end
end
