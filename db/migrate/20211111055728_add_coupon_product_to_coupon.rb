class AddCouponProductToCoupon < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :coupon_product, :string, array: true, default: []
  end
end
