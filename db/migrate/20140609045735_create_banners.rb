class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :path
    end
  end
end
