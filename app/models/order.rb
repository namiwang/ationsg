class Order < ActiveRecord::Base
  # associations
  belongs_to :user

  has_one :transport
  accepts_nested_attributes_for :transport, allow_destroy: true

  has_many :payments
  accepts_nested_attributes_for :payments, allow_destroy: true

  # validations
  validates :user, :transport, presence: true
  validates_with OrderValidator

  # state machine
  include AASM

  aasm do
    state :initialized, :initial => true
    state :created

    event :create do
      transitions from: :initialized, to: :created
    end
  end

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

end
