class Order < ActiveRecord::Base
  # associations
  belongs_to :user

  has_one :transport
  accepts_nested_attributes_for :transport, allow_destroy: true

  has_one :payment
  accepts_nested_attributes_for :payment, allow_destroy: true

  # validations
  validates :user, :transport, presence: true
  validates_with OrderValidator

  # cart, nested hstore
  serialize :cart, ActiveRecord::Coders::NestedHstore

  include SymbolizeHelper
  def cart
    r = symbolize_recursive self.attributes["cart"]
    r[:items].each do |i|
      case i[:type]
      when 'product'
        i[:product] = Product.find(i[:product])
      end
    end
    r
  end

  def total_price
    cart[:total_price].to_i
  end

end
