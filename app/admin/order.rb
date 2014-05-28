ActiveAdmin.register Order do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  # show
  actions :all, except: [:edit, :destroy]
  show do |ad|
    attributes_table do
      row :id
      row :user
      row :cart do
        order_cart_format order.cart
      end
      row :customer_message
      row :transport
      row :payments do
        'TODO'
      end
      row :state do
        I18n.t "activerecord.attributes.order.states.#{order.aasm_state}"
      end
      row I18n.t('active_admin.operate') do
        links = ''.html_safe
        # state machine
        links += state_transition_links order
      end
    end
  end

  
  # index
  index do
    column :id
    column :user
    column :transport
    column :total_price do |order|
      to_sg_dollar order.cart[:total_price]
    end
    column :state do |order|
      I18n.t "activerecord.attributes.order.states.#{order.aasm_state}"
    end

    actions defaults: false do |order|
      links = ''.html_safe
      # view
      links += link_to I18n.t('active_admin.view'), admin_order_path(order), :class => 'member_link'
      # state machine
      links += state_transition_links order
    end
  end

  # state machine integration
  Order.aasm.events.keys.each do |event|
    member_action event.to_s do
      order = Order.find params[:id]
      order.send "#{event.to_s}!" if order.send "may_#{event.to_s}?"
      redirect_to admin_order_path(order)
    end
  end

end
