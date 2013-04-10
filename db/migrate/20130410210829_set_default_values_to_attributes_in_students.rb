class SetDefaultValuesToAttributesInStudents < ActiveRecord::Migration
  def up
  	change_column :students, :status, :string, default: "student"
  	change_column :students, :generation, :integer, default: 1
  	change_column :students, :concentration, :string, default: "wing chun"
  	change_column :students, :enrolled_now, :boolean, default: true
  end

  def down
  end
end
