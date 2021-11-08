class UsersController < ApplicationController 
  
  def index
    @user= User.find(current_user.id)
  end

   def new
    @user= User.new
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
  
  protected
  
  def permitted_values
   params.require(:user).permit(:firstname, :lastname, :email, :username)
  end


end
