class Card < ActiveRecord::Base
  # validations

  # associations
  belongs_to :user
end
