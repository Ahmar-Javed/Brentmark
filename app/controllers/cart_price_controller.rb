class CartPriceController < ApplicationController
  def create
    @cart_price = CartPrice.new(final_price: helpers.final_price)
    if @cart_price.save
      redirect_to checkouts_path, notice: " your cart vaue is submitted "
    else
      render 'error regarding submission'
    end
  end
end
