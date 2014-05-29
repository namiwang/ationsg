class OrderValidator < ActiveModel::Validator
  def validate(record)
    # Items
    record.errors[:base] << "Cart cant be empty" if record.cart[:items].size <= 0
    # Total_price
    record.errors[:base] << "Total Price must be positive" if record.cart[:total_price] <= 0
    # TODO i18n for error messages
  end
end