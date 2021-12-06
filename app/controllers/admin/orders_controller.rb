class Admin::OrdersController < ApplicationController
  include ColSearchSort

  helper_method :sort_column

  def index
    @orders = search_sort_pagination(params[:query], Order)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:order)
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "final_price"
  end
end
