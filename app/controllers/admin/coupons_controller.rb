class Admin::CouponsController < ApplicationController

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
    @coupon= Coupon.new(permitted_values)

    if @coupon.save
      redirect_to admin_coupons_path,notice => " your Coupon has been created "
    else
      render template: "new"
    end
  end

  def new
    @coupon= Coupon.new
  end

  def edit
    @coupon= Coupon.find(params[:id])
  end

  def update
    @coupon= Coupon.find(params[:id])

    if @coupon.update(permitted_values)
      redirect_to admin_coupons_path, :notice=> "Coupon has been updated"
    else
      render template: "edit"
    end
  end

  def show
    @coupon= Coupon.find(params[:id])
  end

   def destroy
    @coupon= Coupon.find(params[:id])
    @coupon.destroy
    redirect_to admin_coupons_path, :notice=> "Coupon has been deleted"
  end

  private

  def permitted_values
  params.require(:coupon).permit(:name, :discount, coupon_product: [])
  end

   def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
  Coupon.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
