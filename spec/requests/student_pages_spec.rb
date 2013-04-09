require 'spec_helper'

describe "Student pages" do

	subject { page }

	describe "index" do
		before do
			sign_in FactoryGirl.create(:student)
			FactoryGirl.create(:student, given_name: "Bob", surname: "Smith", email: "bsmith@example.com", enrolled_now: true)
			FactoryGirl.create(:student, given_name: "Ben", surname: "Smith", email: "ben@example.com", enrolled_now: false)
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
