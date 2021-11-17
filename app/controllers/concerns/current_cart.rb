module CurrentCart
  extend ActiveSupport::Concern

  private
    def set_cart
      @cart = current_user.carts.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        @cart = current_user.carts.create
        session[:cart_id] = @cart.id
    end
end
