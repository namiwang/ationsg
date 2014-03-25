class RemoveLocaleColumnFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :name_zh_ch, :string
  end
end
