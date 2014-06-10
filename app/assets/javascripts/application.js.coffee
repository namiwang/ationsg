# = require jquery
# = require jquery_ujs
# = require bootstrap
# = require_self
# = require navbar
# = require cookies
# = require cart
# = require owl-carousel2/owl.carousel
# = require owl-carousel2/owl.autoplay


$ ->
  $('.need-popover-init').popover()

  # carousel
  $(".banners .owl-carousel").owlCarousel({
      items: 1,
      loop: true,
      autoplay: true
    })
