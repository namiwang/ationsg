class Payment < ActiveRecord::Base
  # associations
  belongs_to :order

  # validations
  validates_presence_of :order
  # validates_inclusion_of :method, :in => %w( paypal ), message: "not valid payment method"
  # TODO message I18N

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :paying

    event :pay do
      transitions from: :initialized, to: :paying
    end
  end

end
