class Transport < ActiveRecord::Base
  # associations
  belongs_to :order, dependent: :destroy

  # validations
  validates_presence_of :recipient_name, :recipient_phone, :recipient_address

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :confirmed
    state :shipping
    state :delivered

    event :confirm do
      transitions from: :initialized, to: :confirmed
    end

    event :ship do
      transitions from: :confirmed, to: :shipping
    end

    event :receive do
      transitions from: :shipping, to: :delivered
    end
  end
end
