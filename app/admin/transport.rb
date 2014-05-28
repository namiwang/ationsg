ActiveAdmin.register Transport do

  
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
      row :recipient_name
      row :recipient_phone
      row :recipient_address
      row :order
      row :state do
        I18n.t "activerecord.attributes.transport.states.#{transport.aasm_state}"
      end
      row I18n.t('active_admin.operate') do
        links = ''.html_safe
        # state machine
        links += state_transition_links transport
      end
    end
  end

  # index
  index do
    column :id
    column :recipient_name
    column :recipient_phone
    column :recipient_address
    column :order
    column :state do |transport|
      I18n.t "activerecord.attributes.transport.states.#{transport.aasm_state}"
    end

    actions defaults: false do |transport|
      links = ''.html_safe
      # view
      links += link_to I18n.t('active_admin.view'), admin_transport_path(transport), :class => 'member_link'
      # state machine
      links += state_transition_links transport
    end
  end

  # state machine integration
  Transport.aasm.events.keys.each do |event|
    member_action event.to_s do
      transport = Transport.find(params[:id])
      transport.send "#{event.to_s}!" if transport.send "may_#{event.to_s}?"
      redirect_to admin_transport_path(transport)
    end
  end

end
