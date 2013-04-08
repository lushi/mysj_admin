require 'spec_helper'

describe "Student pages" do

	subject { page }

	describe "profile page" do
		let(:student) { FactoryGirl.create(:student) }
		before { visit student_path(student) }

		it { should have_selector('h1', text: student.given_name && student.surname)}
		it { should have_selector('title', text: student.given_name && student.surname)}
	end
end
