class OrdersController < ApplicationController
  before_action :set_cart, only: [:index, :create]
  include ColSearchSort

  def index
    @orders = current_user.orders
  end

  def create
    @order = current_user.orders.new(order_params)
    @order.final_price = helpers.final_price
    if @order.buy_products
      redirect_to checkouts_path
    end
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:order)
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def order_params
    params.permit(:username, :first_name, :last_name, :country, :city, :state, :phone, :zip_code, :address, :status)
  end
end
