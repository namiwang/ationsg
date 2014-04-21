class AddBuyerInfo < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_name, :string
    add_column :orders, :buyer_phone, :string
    add_column :users, :phone, :string
  end
end
