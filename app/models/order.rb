class Order < ActiveRecord::Base
  # associations
  belongs_to :user

  # validations
  validates :user, :buyer_name, :buyer_phone, presence: true
  validates :buyer_phone, numericality: true
  # validates_associated :address
end
