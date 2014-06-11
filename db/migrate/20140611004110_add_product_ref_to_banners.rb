class AddProductRefToBanners < ActiveRecord::Migration
  def change
    add_reference :banners, :product, index: true
  end
end
