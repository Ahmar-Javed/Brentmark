class CartItemsController < ApplicationController
  before_action :set_cart, only: [:create, :index]
  before_action :set_product, only: :create
  before_action :set_cart_item, only: [:total_price, :destroy]

  def index
    @cart_items = @cart.cart_items
  end

  def new
    @cart_item = CartItem.new
  end

  def create
    @cart_items = @cart.add_product(@product.id)
    if @cart_items.save
      redirect_to products_path, notice: 'product added to cart'
    end
  end

  def total_price
    @cart_item.update(quantity: params[:qty])
  end

  def destroy
    @cart_item.destroy
    redirect_to checkouts_path
  end

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def set_product
    @product = Product.find_by(id: params[:id])
    return if @product.present?

    redirect_to root_path, alert: 'Invalid Access'
  end
end
