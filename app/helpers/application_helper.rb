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
    @coupon ? current_user.cart.total_price.to_i - @coupon.discount.to_i : current_user.cart.total_price
  end
end
