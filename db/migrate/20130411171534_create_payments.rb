class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :student_id
      t.integer :amount_cents
      t.string :currency
      t.string :method

      t.timestamps
    end
    add_index :payments, [:student_id, :created_at]
  end
end
