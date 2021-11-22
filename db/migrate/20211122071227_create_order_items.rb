class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :product_id, foreign_key: true
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end
