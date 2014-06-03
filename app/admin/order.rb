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
      row :payment do
        link_to "#{Payment.model_name.human} ##{order.payment.id}", admin_payment_path(order.payment)
      end
      row :payment_state do |order|
        I18n.t "activerecord.attributes.payment.states.#{order.payment.aasm_state}"
      end
      row :transport
      row :transport_state do |order|
        I18n.t "activerecord.attributes.transport.states.#{order.transport.aasm_state}"
      end
    end
  end

  # index
  index do
    column :id
    column :user
    column :customer_message do |order|
      order.customer_message.truncate unless order.customer_message.nil?
    end
    column :total_price do |order|
      to_sg_dollar order.total_price
    end
    column :payment do |order|
      link_to "#{Payment.model_name.human} ##{order.payment.id}", admin_payment_path(order.payment)
    end
    column :payment_state do |order|
      I18n.t "activerecord.attributes.payment.states.#{order.payment.aasm_state}"
    end
    column :transport
    column :transport_state do |order|
      I18n.t "activerecord.attributes.transport.states.#{order.transport.aasm_state}"
    end

    actions defaults: false do |order|
      links = ''.html_safe
      # view
      links += link_to I18n.t('active_admin.view'), admin_order_path(order), :class => 'member_link'
    end
  end

end
