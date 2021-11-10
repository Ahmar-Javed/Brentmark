class Admin::UsersController< ApplicationController
  require 'csv'
  before_action :authorize_admin
  helper_method :sort_column, :sort_direction
  def new
    @user= User.new
  end

  def index 
    if params[:query].present?
      @users = User.paginate(page: params[:page], per_page: 3).search_users(params[:query])
    else
      @users = User.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 3)
      respond_to do |format|
        format.html
        format.csv {send_data @users.to_csv}
      end
    end
  end
  
  def create
    @user = User.new(permitted_values)
    @password = User.password
    @user.password = @password
    @user.password_confirmation = @password
    @user.status= true
    @user.skip_confirmation!
    if @user.save   
      UserMailer.with(user: @user, password: @password).welcome_email.deliver_now
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def show
    @user= User.find(params[:id])
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])

    if @user.update(permitted_values)
      redirect_to admin_users_path, :notice=> "User has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, :notice=> "user has been deleted"
  end

  protected
  
  def permitted_values
   params.require(:user).permit(:firstname, :lastname, :email, :username)
  end

  def authorize_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
  
  def permitted_values
    params.require(:user).permit(:username, :firstname, :lastname, :email, :role)
  end

  def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
  User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

end
