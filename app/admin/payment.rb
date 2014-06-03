ActiveAdmin.register Payment do

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
      row :order
      row :total_price do
        to_sg_dollar payment.order.total_price
      end
      row :pay_method do
        I18n.t "payments.method.#{payment.pay_method}"
      end
      row :detail
      row :state do
        I18n.t "activerecord.attributes.payment.states.#{payment.aasm_state}"
      end
      row I18n.t('active_admin.operate') do
        links = ''.html_safe
        # state machine
        links += state_transition_links payment
      end
    end
  end

  # index
  index do
    column :id
    column :order
    column :total_price do |payment|
      to_sg_dollar payment.order.total_price
    end
    column :pay_method do |payment|
      I18n.t "payments.method.#{payment.pay_method}"
    end
    column :state do |payment|
      I18n.t "activerecord.attributes.payment.states.#{payment.aasm_state}"
    end

    actions defaults: false do |payment|
      links = ''.html_safe
      # view
      links += link_to I18n.t('active_admin.view'), admin_payment_path(payment), :class => 'member_link'
      # state machine
      links += state_transition_links payment
    end
  end

  # state machine integration
  Payment.aasm.events.keys.each do |event|
    member_action event.to_s do
      payment = Payment.find(params[:id])
      payment.send "#{event.to_s}!" if payment.send "may_#{event.to_s}?"
      redirect_to admin_payments_path
    end
  end

end
