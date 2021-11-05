class Admin::UsersController< ApplicationController
  require 'csv'
  before_action :authorize_admin

  def new
    @user= User.new
  end

  def index 
    if params[:query].present?
      @users = User.search_username(params[:query])
    else
      @users = User.paginate(page: params[:page], per_page: 5).order(:id)
      respond_to do |format|
        format.html
        format.csv {send_data @users.to_csv}
      end
    end
  end
  
  def show
    @user= User.find(params[:id])
  end

  def edit
    @user= User.find(params[:id])
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, :notice=> "user has been deleted"
  end

  protected

  def authorize_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
