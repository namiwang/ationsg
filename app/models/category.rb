class Category < ActiveRecord::Base
  # associations
  has_many :products
end
