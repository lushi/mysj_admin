FactoryGirl.define do
	factory :student do
		given_name						"John"
		surname								"Doe"
		email									"jdoe@example.com"
		password							"12345678"
		password_confirmation	"12345678"
		sex    								"male"
	 	date_of_birth					1980-10-10
		occupation						"lawyer"
		street								"100 Main St"
		city									"Brooklyn"
		state									"NY"
		zipcode								"11238"
		country								"USA"
		shirt_size						"l"
		pants_size						"l"
		shoe_size							"8"
		status								"disciple"
		generation						1
		concentration					"wing chun"
	end
end