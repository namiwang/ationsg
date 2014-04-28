$ ->
  # add to cart
  $('a.add-to-cart').click ->
    item = {
      type: 'product',
      product: $(@).data('product_id')
    }
    Cart.add(item)
