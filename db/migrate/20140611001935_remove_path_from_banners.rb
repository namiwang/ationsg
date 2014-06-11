class RemovePathFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :path, :string
  end
end
