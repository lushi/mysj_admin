require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
  	before { visit signin_path }

  	it { should have_selector('h1', 	text: 'Sign in') }
  	it { should have_selector('title', text: 'Sign in') }
  	it { should_not have_link('Sign out', href: signout_path)}

  	describe "with invalid information" do
  		before { click_button "Sign in" }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }
  	end

  	describe "with valid information" do
  		let(:student) { FactoryGirl.create(:student) }
  		before do
  			fill_in "Email", 		with: student.email.upcase
  			fill_in "Password",	with: student.password
  			click_button "Sign in"
  		end

      it { should have_link('Students', href: students_path) }
      it { should have_link('Sign out', href: signout_path) }
      it { should have_link('My info', href: student_path(student))}
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
      	before { click_link "Sign out" }
      	it { should have_link('Sign in', href: signin_path) }
      end
    end

    describe "authorization" do

      describe "for non-signed-in students" do
        let(:student) { FactoryGirl.create(:student) }

        describe "in the Students controller" do

          describe "visiting the edit page" do
            before { visit edit_student_path(student) }
            it { should have_link('Sign in', href: signin_path) }
          end

          describe "submitting to the update action" do
            before { put student_path(student) }
            specify { response.should redirect_to(signin_path) }
          end

          describe "visiting the student index" do
            before { visit students_path }
            it { should have_selector('title', text: 'Sign in') }
          end
        end
      end

      describe "for wrong user" do
        let(:student) { FactoryGirl.create(:student) }
        let(:wrong_student) { FactoryGirl.create(:student, email: "wrong@example.com") }
        before { sign_in student }

        describe "visiting Students#edit page" do
          before { visit edit_student_path(wrong_student) }
          it { should_not have_selector('title', text: 'Update settings') }
        end

        describe "submitting a PUT request to the Students#update action" do
          before { put student_path(wrong_student) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
  end
end
