module CartModule
  class Cart

    def initialize
      @items = []
    end

    def items
      @items
    end

    def initialize_from_cookie cookie
      begin
        @items = JSON.parse(cookie).each{ |i| i.symbolize_keys! }
      rescue
        clear
      ensure
        clear unless valid?
        parse_to_model
      end
      return self
    end

    def valid?
      @items.each do |i|
        case i[:type]
        when 'product'
          return false unless Product.exists? i[:product]
        else
          return false
        end
      end
      return true
      # TODO amount must be positive
    end

    def cookie_version
      @items.map do |i|
        case i[:type]
        when 'product'
          {type: 'product', product: i[:product].id}
        end
      end.to_json
    end

    def save_to_order_version
      r = {size: size, total_price: total_price, items: []}
      r[:items] = items.map do |i|
        case i[:type]
        when 'product'
          {type: 'product', product: i[:product].id, price: i[:product].price }
        end
      end
      r
    end

    def parse_to_model
      @items.each do |i|
        case i[:type]
        when 'product'
          i[:product] = Product.find(i[:product])
        end
      end
    end

    def clear
      @items = []
    end

    def size
      @items.size
    end

    def total_price
      @items.reduce(0) do |sum, e|
        case e[:type]
        when 'product'
          sum + e[:product].price
        end
      end
    end
  end
end