namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin = Student.create!(given_name: "Joe",
										surname: "Smith",
										email: "joe@example.com",
										password: "12345678",
										password_confirmation: "12345678",
										sex: "male",
										date_of_birth: 1980-10-10,
										occupation: "lawyer",
										street: "100 Main St",
										city: "Brookyln",
										state: "NY",
										zipcode: "11238",
										country: "USA",
										shirt_size: "l",
										pants_size: "l",
										shoe_size: "8",
										status: "disciple",
										generation: 1,
										concentration: "wing chun",
										enrolled_now: true,
										home_phone: "123-456-7890",
										cell_phone: "098-765-4321")
		admin.toggle!(:admin)
		299.times do |n|
			Student.create!(given_name: Faker::Name.first_name,
			surname: Faker::Name.last_name,
			email: "example-#{n+1}@example.com",
			password: "password",
			password_confirmation: "password",
			sex: n % 2 == 0 ? "male" : "female",
			date_of_birth: 1970-1-1,
			occupation: n % 3 == 0 ? "doctor" : "architect",
			street: Faker::Address.street_address,
			city: Faker::Address.city,
			state: Faker::Address.state_abbr,
			zipcode: Faker::Address.zip_code,
			country: Faker::Address.country,
			shirt_size: n % 2 == 0 ? "m" : "s",
			pants_size: n % 2 == 0 ? "m" : "s",
			shoe_size: n % 2 == 0 ? "9" : "7",
			status: n % 5 == 0 ? "disciple" : "student",
			generation: n % 21 == 0 ? 2 : 1,
			concentration: n % 47 == 0 ? "taichi" : "wing chun",
			enrolled_now: n % 7 ==0 ? true : false,
			home_phone: "111-111-1111",
			cell_phone: "222-222-2222")
		end
	end
end