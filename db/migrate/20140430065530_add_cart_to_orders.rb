class AddCartToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cart, :hstore
  end
end
