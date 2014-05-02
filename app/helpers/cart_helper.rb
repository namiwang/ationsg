module CartHelper
#   def cart_init
#     @cart = Cart.new.initialize_from_cookie cookies[:cart_items]
#     cart_save_to_cookie
#   end

#   def cart_clear
#     @cart.clear
#     cart_save_to_cookie
#   end

#   def cart_save_to_cookie
#     cookies[:cart_items] = @cart.cookie_version
#   end
end