class Product < ActiveRecord::Base
  # associations
  has_one :category
end
