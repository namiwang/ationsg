class AddRibbonToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ribbon, :string, default: ''
  end
end
