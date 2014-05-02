$ ->
  # add to cart
  $('a.add-to-cart').click ->
    item = {
      type: 'product',
      product: $(@).data('product-id')
    }
    Cart.add(item)
