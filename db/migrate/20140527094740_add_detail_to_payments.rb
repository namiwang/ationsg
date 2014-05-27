class AddDetailToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :detail, :string
    remove_column :payments, :string
  end
end
