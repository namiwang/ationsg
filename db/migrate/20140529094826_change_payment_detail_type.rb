class ChangePaymentDetailType < ActiveRecord::Migration
  def change
    change_column :payments, :detail, :text
  end
end
