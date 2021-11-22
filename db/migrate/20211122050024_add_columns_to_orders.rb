class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :user_id, :integer
  end
end
