class AddCurrentStudentToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :enrolled_now?, :boolean
  end
end