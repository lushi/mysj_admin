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

class PaymentPlan < ActiveRecord::Base
  attr_accessible :amount_cents, :name, :currency
  has_many :payment_plan_choices, dependent: :destroy
  has_many :students, through: :payment_plan_choices
end
