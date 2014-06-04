class Payment < ActiveRecord::Base
  # associations
  belongs_to :order

  # validations
  validates_presence_of :order
  validates_inclusion_of :method, :in => %w( paypal card ), message: "not valid payment method"
  # TODO message I18N

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :paying
    state :success

    event :pay do
      transitions from: :initialized, to: :paying
    end

    event :receive do
      transitions from: [:initialized, :paying], to: :success
    end
  end

end
