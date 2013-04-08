class AddAuthTokenToStudents < ActiveRecord::Migration
  def change
    add_column :students, :auth_token, :string
    add_index :students, :auth_token
  end
end
