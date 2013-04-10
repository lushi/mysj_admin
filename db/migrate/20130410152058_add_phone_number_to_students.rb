class AddPhoneNumberToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :home_phone, :string
  	add_column :students, :cell_phone, :string
  end
end
