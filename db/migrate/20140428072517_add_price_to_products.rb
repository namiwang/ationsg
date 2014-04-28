class AddPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :integer, default: 0
  end
end
