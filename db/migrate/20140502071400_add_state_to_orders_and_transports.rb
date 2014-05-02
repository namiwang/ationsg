class AddStateToOrdersAndTransports < ActiveRecord::Migration
  def change
    add_column :orders, :aasm_state, :string
    add_column :transports, :aasm_state, :string
  end
end
