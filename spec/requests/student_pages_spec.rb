require 'spec_helper'

describe "Student pages" do

	subject { page }

	let (:student) { FactoryGirl.create(:student) }
	before { sign_in student }

	it "should not list 'Add a new student'" do
		page.should_not have_selector('li', text: 'Add a new student')
	end

	describe "admin adding a new student" do
		let(:admin) { FactoryGirl.create(:admin) }
		before do
			sign_in admin
			visit new_student_path
		end

		let(:submit) { "Create new student" }

		describe "with invalid information" do
			it "should not create a student" do
				expect { click_button submit }.not_to change(Student, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Given name", with: "Jane"
				fill_in "Surname", with: "Doe"
				fill_in "Email", with: "janedoe@example.com"
				fill_in "Password", with: "12345678"
				fill_in "Confirmation", with: "12345678"
			end

			it "should create a user" do
				expect { click_button submit }.to change(Student, :count).by(1)
			end
		end
	end


	describe "index" do

		let (:student) { FactoryGirl.create(:student) }

		before do
			sign_in student
			visit students_path
		end

		it { should have_selector('title', text: 'Current students') }
		it { should have_selector('h1', text: 'Current students') }

		it "should list each current student" do
			Student.find_all_by_enrolled_now(true).each do |s|
				page.should have_selector('li', text: s.given_name)
				page.should have_selector('li', text: s.surname)
			end
		end

		it "should not list students not enrolled now" do
			Student.find_all_by_enrolled_now(false).each do |s|
				page.should_not have_select('li', text: s.given_name)
				page.should_not have_select('li', text: s.surname)
			end
		end

		describe "delete links" do

			it { should_not have_link('delete') }

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
					sign_in admin
					visit students_path
				end

				it { should have_link('delete', href: student_path(Student.first)) }
				it "should be able to delete another user" do
					expect { click_link('delete') }.to change(Student, :count).by(-1)
				end
				it { should_not have_link('delete', href: student_path(admin)) }
			end
		end
	end

	describe "profile page" do
		let(:student) { FactoryGirl.create(:student) }
		before { sign_in(student) }
		before { visit student_path(student) }

		it { should have_selector('h1', text: student.given_name && student.surname)}
		it { should have_selector('title', text: student.given_name && student.surname)}
	end

	describe "edit" do
		let(:student) { FactoryGirl.create(:student) }
		before { sign_in(student) }
		before { visit edit_student_path(student) }

		describe "page" do
			it { should have_selector('h1', text: "Update settings") }
			it { should have_selector('title', text: 'Update settings') }
		end

		describe "with invalid information" do
			before { click_button "Save changes" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			let(:new_email) { "new@example.com"}

			before do
				fill_in "Email", with: new_email
				fill_in "Password", with: student.password
				fill_in "Confirm password", with: student.password
				click_button "Save changes"
			end

			it { should have_selector('div.alert.alert-success')}
			it { should have_link('Sign out', href: signout_path) }
			specify { student.reload.email.should == new_email }
		end
	end
end
