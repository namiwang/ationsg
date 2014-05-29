class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :balance, default: 100
      t.references :user, index: true
    end
  end
end
