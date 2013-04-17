# == Schema Information
#
# Table name: payment_plans
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  amount_cents :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  currency     :string(255)
#

require 'spec_helper'

describe PaymentPlan do

	let(:payment_plan) { FactoryGirl.create(:payment_plan) }

	subject { payment_plan }

	it { should respond_to(:name) }
	it { should respond_to(:amount_cents) }
	it { should respond_to(:currency) }
	it { should respond_to(:students) }

  describe "students associations" do
    let(:student) { FactoryGirl.create(:student) }
    before do
      student.payment_plans << payment_plan
    end

    its(:students) { should be_include(student) }

    describe "when link between student and a payment plan is deleted" do
      let(:student) { FactoryGirl.create(:student) }
      before { student.payment_plans.delete(PaymentPlan.find_by_name(payment_plan.name)) }

      it "should not delete associated record in payment plan" do
        PaymentPlan.find_by_name(payment_plan.name).should_not be_nil
      end
    end
  end
end
