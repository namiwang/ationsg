class RechargePayment < ActiveRecord::Base
  # associations
  belongs_to :user
  belongs_to :card

  # validations
  validates :pay_method, inclusion: { in: %w(paypal), message: 'invalid pay method' }
  validates :user, :card, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :paying
    state :success
    state :canceled

    event :pay do
      transitions from: :initialized, to: :paying
    end

    event :receive do
      transitions from: :paying, to: :success
      after do
        card.recharge amount        
      end
    end

    event :cancel do
      transitions from: :paying, to: :canceled
    end
  end

end
