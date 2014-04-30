class Order < ActiveRecord::Base
  # associations
  belongs_to :user
  has_one :transport
  accepts_nested_attributes_for :transport, allow_destroy: true

  # validations
  validates :user, :transport, presence: true
end
