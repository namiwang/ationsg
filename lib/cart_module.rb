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
      ensure
      end
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

    def parse_to_model
      @items.each do |i|
        case i[:type]
        when 'product'
          i[:product] = Product.find(i[:product])
        end
      end
    end

    def reset
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