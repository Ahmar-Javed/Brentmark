require 'csv'

class Admin::UsersController< ApplicationController
  before_action :authorize_admin
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  
  helper_method :sort_column, :sort_direction

  include ColSearchSort

  def new
    @user= User.new
  end

  def index 
    @users = search_sort_pagination(params[:query], User)
    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv}
    end
  end

  def create
    if User::invite(user_params) 
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "user has been deleted"
  end

  private

  def authorize_admin
    redirect_to new_user_session_path unless current_user.admin?
  end

  def set_user
    @user= User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :firstname, :lastname, :email, :role)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end
end
