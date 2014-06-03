# due to this issue, have to changed the column name
# https://github.com/gregbell/active_admin/issues/3191
class RenameMethodToPayMethodInPayments < ActiveRecord::Migration
  def change
    rename_column :payments, :method, :pay_method
  end
end
