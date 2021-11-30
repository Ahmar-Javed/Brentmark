class CheckoutsController < ApplicationController 
  before_action :set_order, only: [:index, :confirm_order]
  
  def index
    @user = current_user
    @cart =  current_user.cart
    if params[:name]
      @coupon = Coupon.find_by(name: params[:name])
    end
  end
  
  def confirm_order 
    if params[:order][:payment_method] == 'card'
      @session = StripeService.new.payment_procedure(@order)
      @order.paid!
    else
      redirect_to checkouts_path, notice: 'your order is placed successfully'
    end
  end

  def show; end

  private

  def set_order
    @order = current_user.orders.last
  end

  def user_params
    params.require(:user).permit(:username,:firstname,:lastname,:country,:city, :state, :phone, :zip_code,:address)
  end
end
