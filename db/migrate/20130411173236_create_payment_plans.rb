class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.string :name
      t.integer :amount_cents

      t.timestamps
    end
  end
end
