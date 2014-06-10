class Banner < ActiveRecord::Base
  # associations
  has_many :images, as: :imageable # TODO should use has_one but cannot save via activeadmin
  accepts_nested_attributes_for :images

  def image
    images.first
  end
end
