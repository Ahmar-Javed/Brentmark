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
  
  resources :users
  match '/products/add_to_cart/:id', to: 'products#add_to_cart', as: :add_to_cart, via: [:get, :post]
  match '/products/remove_from_cart/:id', to: 'products#remove_from_cart', as: :remove_from_cart, via: [:delete]
  resources :products
  resources :cart_items
  post '/total_price', to: "cart_items#total_price"
  resources :carts
  resources :checkouts
  resources :states, only: :index
  resources :cities, only: :index
end
