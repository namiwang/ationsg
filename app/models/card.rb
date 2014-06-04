class Card < ActiveRecord::Base
  # validations
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # associations
  belongs_to :user

  def pay(amount)
    return false unless self.balance >= amount
    self.balance -= amount
    self.save
  end

  def recharge(amount)
    self.balance += amount
    self.save!
  end
end
