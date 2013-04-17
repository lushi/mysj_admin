# == Schema Information
#
# Table name: payment_plan_choices
#
#  id              :integer          not null, primary key
#  payment_plan_id :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe PaymentPlanChoice do
	let(:student) { FactoryGirl.create(:student) }
	let(:payment_plan) { FactoryGirl.create(:payment_plan) }

	describe "new record in Payment Plan Choice" do
		before do
			student.payment_plans << payment_plan
		end

		it "should create association between student and payment plan in payment plan choice" do
			PaymentPlanChoice.find_by_student_id(student.id).payment_plan_id.should == payment_plan.id
		end
	end
end
