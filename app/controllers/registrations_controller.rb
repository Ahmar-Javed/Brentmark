class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource
    respond_to do |format|
      format.js
      format.html
    end
  end

def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_to do |format|
          format.js {respond_with resource, location: after_sign_up_path_for(resource)}
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_to do |format|
          format.js {respond_with resource, location: after_inactive_sign_up_path_for(resource)}
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
          format.js 
        end
    end
  end

  def confirm
       #  @user = User.find_by_confirmation_token!(params[:id])
       #  if @user.update_attributes(confirmed: true)
       #      redirect_to login_path
       # end
  end
end
