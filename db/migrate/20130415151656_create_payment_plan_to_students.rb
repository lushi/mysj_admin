class CreatePaymentPlanToStudents < ActiveRecord::Migration
  def change
    create_table :payment_plan_to_students do |t|
      t.integer :payment_plan_id
      t.integer :student_id

      t.timestamps
    end
  end
end
