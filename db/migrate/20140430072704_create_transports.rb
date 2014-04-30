class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.string :recipient_name
      t.string :recipient_phone
      t.string :recipient_address

      t.timestamps
    end
  end
end
