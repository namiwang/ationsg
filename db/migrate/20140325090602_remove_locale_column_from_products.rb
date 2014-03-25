class RemoveLocaleColumnFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :name_zh_cn, :string
    remove_column :products, :description_zh_ch, :text
  end
end
