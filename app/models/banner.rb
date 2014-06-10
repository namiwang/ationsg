class Banner < ActiveRecord::Base
  # associations
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images

  def image
    images.first
  end
end
