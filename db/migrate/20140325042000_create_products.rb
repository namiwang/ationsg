class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :name_zh_cn
      t.text :description
      t.text :description_zh_cn

      t.timestamps
    end
  end
end
