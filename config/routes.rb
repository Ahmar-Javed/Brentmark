Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', confirmations: "confirmations"}
  devise_scope :user do  
    root "devise/sessions#new"  
    get '/:token/confirm_email/', :to =>'devise/sessions#new', as: 'confirm_email'
  end

  namespace :admin do
    resources :users
  end
end


