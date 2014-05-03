class AddCustomerMessageToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :customer_message, :string
  end
end
