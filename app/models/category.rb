class Category < ActiveRecord::Base
  # associations
  has_many :products
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  def cover
    images.first
  end
end
