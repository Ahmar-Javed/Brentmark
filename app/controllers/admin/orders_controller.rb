class Admin::OrdersController < ApplicationController
  include ColSearchSort

  helper_method :sort_column, :sort_direction

  def index
    @orders = search_sort_pagination(params[:query], Order)
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:order)
  end

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "final_price"
  end
end
