$ ->
  # like btn
  $('a.product-like').click ->
    this_btn = $ @
    if this_btn.hasClass 'liked'
      this_btn.removeClass('liked')
      # change class
      # send query
      $.ajax {
        url: this_btn.data 'unlike-path',
      }
    else
      this_btn.addClass('liked')
      $.ajax {
        url: this_btn.data 'like-path',
      }

  # add to cart
  $('a.product-add-to-cart').click ->
    item = {
      type: 'product',
      product: $(@).data('product-id')
    }
    Cart.add(item)

  # add to cart
