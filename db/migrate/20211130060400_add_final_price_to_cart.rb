class AddFinalPriceToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :final_price, :decimal
  end
end
