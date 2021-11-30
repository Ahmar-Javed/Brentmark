class Admin::AdminsController < ApplicationController
  before_action :check_admin
  
  def check_admin
    unless current_user.admin?
      redirect_to new_admin_user_path
    end
  end
end
