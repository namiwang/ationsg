$ ->
  class CART
    constructor: ->
      try
        @items = JSON.parse(Cookies('cart_items'))
      catch err
        @items = []
      finally
        @refresh()

    add: (item) ->
      @items.push item
      @refresh()

    size: ->
      @items.length

    refresh: ->
      @save_to_cookie()
      @refresh_btn()

    refresh_btn: ->
      cart_partial = $('<div>', {id: 'cart-partial'}).load "/cart/partial?rnd=#{Math.random()}", (response, status, xhr) -> 
        if status is 'error'
          cart_partial.load "/cart/partial?rnd=#{Math.random()}"
      # TODO, now will load again if load failed, but that's not enough

      cart_btn = $('nav.navbar ul.cart a.cart-btn')
      cart_span = $('nav.navbar ul.cart span.glyphicon.glyphicon-shopping-cart')
      cart_btn.fadeOut(400, =>
        cart_span
          .text("(#{@size()})")
        cart_btn.data('bs.popover').options.content = cart_partial[0].outerHTML
        cart_btn.fadeIn())
      
    save_to_cookie: ->
      Cookies.set('cart_items', JSON.stringify(@items))

  root = exports ? this
  root.Cart = new CART unless root.Cart

  # TODO
  # cart partial should not hide if mouse enter cart partial