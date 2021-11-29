module ApplicationHelper
  def sortable(column, username = nil)
    username ||= column.titleize
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to username, sort: column, direction: direction
  end

  def countries_list
    CS.countries.map { |c| [c[1], c[0]] }
  end

  def final_price
    @prices = @cart.cart_items.map do |cart_item| 
      (@coupon&.products&.include?cart_item.product).present? ? coupon_discount_price(cart_item) : cart_item.total_price
    end

    @prices.sum
  end
  
  def coupon_discount_price (item)
    if @coupon.discount_type == 'cash'
      item.total_price.to_i - @coupon.discount.to_i
    else
      item.total_price.to_i * @coupon.discount.to_i/100
    end
  end

end
