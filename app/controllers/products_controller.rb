class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index
    @products= Product.all
  end

  def show
    @product= Product.find(params[:id])
  end


  def add_to_cart 
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to users_path
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Product.find(session[:cart])
  end
end
