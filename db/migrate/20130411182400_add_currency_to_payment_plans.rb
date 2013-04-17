class AddCurrencyToPaymentPlans < ActiveRecord::Migration
  def change
		add_column :payment_plans, :currency, :string
  end
end
