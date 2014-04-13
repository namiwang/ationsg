# = require jquery
# = require jquery.turbolinks
# = require jquery_ujs
# = require jquery.sticky-kit
# = require bootstrap
# = require turbolinks

$( ->
  $('.container.header div.to-stick')
    .stick_in_parent({parent: 'body', sticky_class: 'is-stuck'})
    .on('sticky_kit:stick', (e) ->
      $(e.target).hide().css({width: '100%'}).fadeIn()
    )
)
