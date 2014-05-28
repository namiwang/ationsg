module ActiveAdmin::ViewsHelper
  def state_transition_links(resource)
    links = ''.html_safe
    resource.class.aasm.events.keys.each do |event|
      if resource.send "may_#{event.to_s}?"
        links += link_to I18n.t("activerecord.attributes.#{resource.class.name.downcase}.transitions.#{event.to_s}"), send("#{event.to_s}_admin_#{resource.class.name.downcase}_path", resource), class: 'member_link'
      end
    end
    links
  end 
end 
