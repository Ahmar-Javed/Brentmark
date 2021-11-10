class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])
  end

  def after_sign_in_path_for(resource)
    return admin_products_path if resource.admin?
    return edit_user_registration_path if resource.status?
 
    users_path
  end




end
