class Payment < ActiveRecord::Base
  # associations
  belongs_to :order, dependent: :destroy

  # validations
  # validates_presence_of :order
  validates_inclusion_of :method, :in => %w( paypal ), message: "not valid payment method"
  # TODO message I18N

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :created

    event :create do
      transitions from: :initialized, to: :created
    end
  end

  
end
