class CheckoutsController < ApplicationController
  def index
    @cart= Cart.find(session[:cart_id])
  end

  def new
  end

  def edit
  end

end
