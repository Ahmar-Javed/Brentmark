class Admin::CouponsController < ApplicationController
  before_action :set_coupon, only: [:edit, :update, :show, :destroy]
  before_action :check_admin
  
  include ColSearchSort

  def index
    @coupons = search_sort_pagination(params[:query], Coupon)
    respond_to do |format|
      format.html
      format.csv {send_data @coupons.to_csv}
    end
  end

  def create
    @coupon= Coupon.new(coupon_params)
    if @coupon.save
      redirect_to admin_coupons_path, notice: " your Coupon has been created "
    else
      render template: "new"
    end
  end
  
  def new
    @coupon= Coupon.new
  end

  def edit; end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path, notice: "Coupon has been updated"
    else
      render template: "edit"
    end
  end

  def show
  end

  def apply_coupon
    @coupon= Coupon.find(params[:id])
  end

   def destroy
    @coupon= Coupon.find(params[:id])
    @coupon.destroy
    redirect_to admin_coupons_path, notice: "Coupon has been deleted"
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name,:discount_type, :discount, product_ids: [])
  end

  def set_coupon
    @coupon= Coupon.find(params[:id])
  end

  def sort_column
    Coupon.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def check_admin
    unless current_user.admin?
      redirect_to new_admin_user_path
    end
  end
end
