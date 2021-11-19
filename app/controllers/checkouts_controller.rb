class CheckoutsController < ApplicationController
  def index
    @cart= current_user.cart
    @user= current_user
    if params[:name]
      @coupon = Coupon.find_by(name: params[:name])
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to checkouts_path, notice: "User Info has been taken"
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username,:firstname,:lastname,:country,:city, :state, :phone)
  end
end
