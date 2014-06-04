module ActiveAdmin::ViewsHelper
  def state_transition_links(resource)
    links = ''.html_safe
    resource.class.aasm.events.keys.each do |event|
      if resource.send "may_#{event.to_s}?"
        links += link_to locale_transition(resource.class.name.underscore, event.to_s), send("#{event.to_s}_admin_#{resource.class.name.underscore}_path", resource), class: 'member_link'
      end
    end
    links
  end 

  def order_cart_format(cart)
    # TODO soooooooooooo ugly
    r = ''.html_safe
    br = '<br/>'.html_safe
    r << "size: #{cart[:size]}".html_safe << br
    r << "cart: " << br
    cart[:items].each do |item|
      case item[:type]
      when 'product'
        line = link_to item[:product].name, product_path(item[:product])
      end
      r << line << br
    end
    r << "total_price: #{to_sg_dollar cart[:total_price]}".html_safe << br
    r
  end
end 
