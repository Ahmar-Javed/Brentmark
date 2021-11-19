class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    product.price.to_i * quantity.to_i
  end

  # def final_price
  #   total_price.to_i - @coupon.discount.to_i
  # end

end
