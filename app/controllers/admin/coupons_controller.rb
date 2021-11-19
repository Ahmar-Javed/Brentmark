class Admin::CouponsController < ApplicationController
  before_action :set_coupon, only: [:edit, :update, :show, :destroy]
  before_action :check_admin

  def index
    if params[:query].present?
      @coupons = Coupon.paginate(page: params[:page], per_page: 3).search_coupons(params[:query])
    else
      @coupons = Coupon.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 3)
      respond_to do |format|
        format.html
        format.csv {send_data @coupons.to_csv}
      end
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

  def edit
  end

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
    params.require(:coupon).permit(:name,:discount_type, :discount, coupon_product: [])
  end

  def set_coupon
    @coupon= Coupon.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
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
