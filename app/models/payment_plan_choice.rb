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

class PaymentPlanChoice < ActiveRecord::Base
	belongs_to :payment_plan
	belongs_to :student

	validates :payment_plan_id, presence: true
	validates :student_id, presence: true
	default_scope order: 'payment_plan_choices.created_at DESC'
end
