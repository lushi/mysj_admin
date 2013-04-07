class ChangeNameColumnNameInStudents < ActiveRecord::Migration
  def up
  	rename_column :students, :name, :surname
  end

  def down
  end
end
