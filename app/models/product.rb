class Product < ActiveRecord::Base
  # associations
  belongs_to :category
end
