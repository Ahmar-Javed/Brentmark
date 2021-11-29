class CheckoutController < ApplicationController 
  def index
    @cart= current_user.cart
    @user= current_user
    if params[:name]
      @coupon = Coupon.find_by(name: params[:name])
    end
  end
  
  def create
    @cart= current_user.cart
    @order = current_user.orders.create(final_price: helpers.final_price)
    
    current_user.cart.cart_items.each do |cart_item|
      @order.order_items.create(quantity: cart_item.quantity, product: cart_item.product)
    end

    current_user.cart.cart_items.destroy_all

    if params[:payment_method] == 'card'
      @session = StripeService.new(current_user, :final_price).payment_procedure(@order)
    else
      redirect_to checkout_index_path, notice: 'your order is created'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to checkout_index_path, notice: "User Info has been taken"
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username,:firstname,:lastname,:country,:city, :state, :phone, :zip_code,:address)
  end
end
