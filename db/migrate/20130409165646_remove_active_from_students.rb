class RemoveActiveFromStudents < ActiveRecord::Migration
  def up
  	remove_column :students, :active?
  end

  def down
  end
end
