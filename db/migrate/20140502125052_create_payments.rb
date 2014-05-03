class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :method
      t.string :aasm_state, :string
      t.references :order, index: true

      t.timestamps
    end
  end
end
