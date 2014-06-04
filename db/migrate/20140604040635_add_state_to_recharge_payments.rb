class AddStateToRechargePayments < ActiveRecord::Migration
  def change
    add_column :recharge_payments, :aasm_state, :string
  end
end
