class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @orders = current_user.orders
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated"
    else
      render template: "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to users_path, notice: "Product has been deleted"
  end

  protected

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
