class Product < ActiveRecord::Base
  # associations
  belongs_to :category
  has_many :images, as: :imageable
  accepts_nested_attributes_for :images, allow_destroy: true

  def cover
    images.first ? images.first.url : ActionController::Base.helpers.image_path('missing.png')
  end
end
