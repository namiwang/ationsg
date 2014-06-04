ActiveAdmin.register RechargePayment do

  # index
  index do
    column :id
    column :user
    column :card
    column :amount do |recharge_payment|
      to_sg_dollar recharge_payment.amount
    end
    column :pay_method do |recharge_payment|
      I18n.t "payments.method.#{recharge_payment.pay_method}"
    end
    column :state do |recharge_payment|
      locale_state 'recharge_payment', recharge_payment.aasm_state
    end

    actions defaults: false do |recharge_payment|
      links = ''.html_safe
      # state machine
      links += state_transition_links recharge_payment
    end
  end

  # state machine integration
  RechargePayment.aasm.events.keys.each do |event|
    member_action event.to_s do
      recharge_payment = RechargePayment.find(params[:id])
      recharge_payment.send "#{event.to_s}!" if recharge_payment.send "may_#{event.to_s}?"
      redirect_to admin_recharge_payments_path
    end
  end
  
end
