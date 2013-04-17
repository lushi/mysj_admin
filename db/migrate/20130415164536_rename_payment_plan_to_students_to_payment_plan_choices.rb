class RenamePaymentPlanToStudentsToPaymentPlanChoices < ActiveRecord::Migration
  def up
  	rename_table :payment_plan_to_students, :payment_plan_choices
  end

  def down
  	rename_table :payment_plan_choices, :payment_plan_to_students
  end
end
