FactoryGirl.define do
	factory :student do
		given_name						"John"
		surname								"Doe"
		email									"jdoe@example.com"
		password							"12345678"
		password_confirmation	"12345678"
	end
end