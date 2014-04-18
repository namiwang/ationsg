# add to cart
$('a.add-to-cart').click (e) =>
  this_btn = e.target
  item = {product: $(this_btn).data('product_id')}
  Cart.add(item)
