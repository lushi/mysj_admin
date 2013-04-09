class ChangeEnrolledNowInStudents < ActiveRecord::Migration
  def up
  	rename_column :students, :enrolled_now?, :enrolled_now
  end

  def down
  end
end
