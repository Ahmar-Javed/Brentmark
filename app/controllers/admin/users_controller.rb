class Admin::UsersController< ApplicationController
 
  def index 
    if params[:query].present?
      @users = User.search_username(params[:query])
    else
      @users = User.paginate(page: params[:page], per_page: 5)
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
    redirect_to users_path, :notice=> "user has been deleted"
  end
end
