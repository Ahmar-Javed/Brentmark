class CartsController <ApplicationController 
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
 
  def new
    @cart = Cart.new
  end

  def create
    @cart= Cart.new
    if @cart.save
      redirect_to carts_path notice: 'cart is created'
    end  
  end
  
  def show
    if current_user
      @cart = current_user.cart 
    else
      @cart = Cart.find(session[:cart_id])
    end
  end

  private
  
  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

end
