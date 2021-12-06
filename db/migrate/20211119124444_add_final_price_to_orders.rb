class AddFinalPriceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :final_price, :integer
  end
end
