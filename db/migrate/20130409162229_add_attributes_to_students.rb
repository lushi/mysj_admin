class AddAttributesToStudents < ActiveRecord::Migration
  def change
		add_column :students, :sex, :string
  	add_column :students, :date_of_birth, :date
  	add_column :students, :occupation, :string
  	add_column :students, :street, :string
  	add_column :students, :city, :string
  	add_column :students, :state, :string
  	add_column :students, :zipcode, :string
  	add_column :students, :country, :string
  	add_column :students, :shirt_size, :string
  	add_column :students, :pants_size, :string
  	add_column :students, :shoe_size, :string
  	add_column :students, :active?, :boolean
  	add_column :students, :status, :string
  	add_column :students, :generation, :integer
  	add_column :students, :concentration, :string
  end
end
