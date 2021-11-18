class CartItemsController < ApplicationController
  before_action :set_cart, only: [:create, :index]

  def index
    @cart_items= @cart.cart_items
  end

  def new
    @cart_item = CartItem.new
  end

  def create
    product= Product.find(params[:product_id])
    @cart_items= @cart.add_product(product.id)
    if @cart_items.save
       redirect_to products_path, notice: 'product added to cart'
    end
  end

  def total_price
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(quantity: params[:qty])
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def set_cart
    @cart = current_user.cart
  end
end
