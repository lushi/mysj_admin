# == Schema Information
#
# Table name: payments
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  amount_cents :integer
#  currency     :string(255)
#  method       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  for          :string(255)
#  memo         :string(255)
#

require 'spec_helper'

describe Payment do

	let(:student) { FactoryGirl.create(:student) }
	before do
		@payment = student.payments.build(amount_cents: 41000,
										currency: "USD", method: "check")
	end

	subject { @payment }

	it { should respond_to(:student_id) }
	it { should respond_to(:amount_cents) }
	it { should respond_to(:currency) }
	it { should respond_to(:method) }
	its(:student) { should == student }

	it { should be_valid }

	describe "when student_id is not present" do
		before { @payment.student_id = nil }
		it { should_not be_valid }
	end

	describe "accessible attributes" do
		it "should not allow access to student_id" do
			expect do
				Payment.new(student_id: student.id)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end
end
