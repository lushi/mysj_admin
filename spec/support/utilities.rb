def sign_in(student)
	visit signin_path
	fill_in "Email", with: student.email
	fill_in "Password", with: student.password
	click_button "Sign in"
	# Sign in when not using Capybara as well.
	cookies[:auth_token] = student.auth_token
end