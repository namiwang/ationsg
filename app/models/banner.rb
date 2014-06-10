class Banner < ActiveRecord::Base
  # associations
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image
end
