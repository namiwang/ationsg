class AddOrderRefToTransports < ActiveRecord::Migration
  def change
    add_reference :transports, :order, index: true
  end
end
