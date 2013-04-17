class AddColumnForToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :for, :string
  end
end
