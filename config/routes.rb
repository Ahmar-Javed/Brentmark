Rails.application.routes.draw do
  resources :invites, controller: 'invitation/invites', only: [:new, :create]
  devise_for :users, controllers: { registrations: 'registrations'}
  devise_scope :user do  
    root "devise/sessions#new"  
    get '/:token/confirm_email/', :to =>'devise/sessions#new', as: 'confirm_email'
  end



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
  resources :cart_items
  resources :states, only: :index
  resources :cities, only: :index
  resources :orders
  post '/total_price', to: 'cart_items#total_price'
  put '/add_order_info/:id', to: 'checkouts#add_order_info', as: 'add_order_info'
  get '/confirm_order/:id', to: 'checkouts#confirm_order', as: 'confirm_order'
  resources :carts
  resources :checkouts
end
