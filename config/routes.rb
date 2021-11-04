Rails.application.routes.draw do
  resources :invites, controller: 'invitation/invites', only: [:new, :create]
  devise_for :users, :controllers => { registrations: 'registrations', confirmations: "confirmations", invitations: "invitations"}
  devise_scope :user do  
    root "devise/sessions#new"  
    get '/:token/confirm_email/', :to =>'devise/sessions#new', as: 'confirm_email'
  end
  namespace :admin do
    resources :users
  end
end


