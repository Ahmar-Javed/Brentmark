class Admin::OrdersController < ApplicationController
  include ApplicationHelper

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def create
    if params[:order] == 'cash'
      @order = current_user.orders.create(final_price: final_price)
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(quantity: cart_item.quantity, product: cart_item.product)
      end
      current_user.cart.cart_items.destroy_all
      redirect_to checkouts_path, notice: 'Your Order is created'
    end
  end
end
