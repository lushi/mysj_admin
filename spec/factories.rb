FactoryGirl.define do
	factory :student do
		given_name						"Joe"
		surname								"Smith"
		sequence(:email) { |n| "person_#{n}@example.com"}
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
		enrolled_now					true

		factory :admin do
			admin true
		end
	end

	factory :payment_plan do
		name 									"tuition-quarterly"
		amount_cents					"45000"
		currency							"USD
"	end

	factory :payment do
		amount_cents					"42000"
		currency							"USD"
		method								"check"
		student
	end
end