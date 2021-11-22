class CheckoutsController < ApplicationController
  def index
    @cart= current_user.cart
    @user= current_user
    
    # session = Stripe::Checkout::Session.create({
    #   payment_method_types: ['card'],
    #   line_items: [
    #     {
    #     currency: 'usd',
    #     amount: final
    #     },
    #     price_data: {
    #       currency: 'usd',
    #     },
    #     quantity: 1,
    #   ],
    #   mode: 'payment',
    #   success_url: 'https://example.com/success',
    #   cancel_url: 'https://example.com/cancel',
    # })
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
