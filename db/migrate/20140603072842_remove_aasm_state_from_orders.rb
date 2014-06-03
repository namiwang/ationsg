class RemoveAasmStateFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :aasm_state, :string
  end
end
