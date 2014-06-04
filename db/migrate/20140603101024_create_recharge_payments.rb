class CreateRechargePayments < ActiveRecord::Migration
  def change
    create_table :recharge_payments do |t|
      t.references :user, index: true
      t.references :card, index: true
      t.string :pay_method
      t.integer :amount

      t.timestamps
    end
  end
end
