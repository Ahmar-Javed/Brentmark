class AddNewColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :country, :string
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :username, :string
    add_column :orders, :status, :string
    add_column :orders, :address, :string
  end
end
