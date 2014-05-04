class Transport < ActiveRecord::Base
  # associations
  belongs_to :order, dependent: :destroy

  # validations
  validates_presence_of :recipient_name, :recipient_phone, :recipient_address

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :created
    state :shipped

    event :create do
      transitions from: :initialized, to: :created
    end

    event :ship do
      transitions from: :created, to: :shipped
    end
  end
end