class AddCartItemsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cart_items, :hstore
  end
end
