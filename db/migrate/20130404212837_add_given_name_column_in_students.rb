class AddGivenNameColumnInStudents < ActiveRecord::Migration
  def change
  	add_column :students, :given_name, :string
  end
end
