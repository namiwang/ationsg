class Transport < ActiveRecord::Base
  # associations
  belongs_to :order

  # validations
  validates_presence_of :recipient_name, :recipient_phone, :recipient_address
end
