$ ->
  $('.img-slide.img-slide-wrapper nav.img-slide.imgs-nav a.img-slide.img-link').click ->
    img_primary = $(@).closest('.img-slide.img-slide-wrapper').find('.img-slide.img-primary')
    img_primary.css('backgroundImage',$(@).css('backgroundImage'))