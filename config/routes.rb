Rails.application.routes.draw do
  resources :invites, controller: 'invitation/invites', only: [:new, :create]
  devise_for :users, :controllers => { registrations: 'registrations'}
  devise_scope :user do  
    root "devise/sessions#new"  
    get '/:token/confirm_email/', :to =>'devise/sessions#new', as: 'confirm_email'
  end
  namespace :admin do
    resources :products
    resources :users
    resources :categories
    resources :coupons
  end
  resources :users
end
