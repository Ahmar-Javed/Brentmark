class CheckoutsController < ApplicationController
  def index
    @cart= current_user.cart
  end

end
