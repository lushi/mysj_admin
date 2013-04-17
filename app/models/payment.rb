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

class Payment < ActiveRecord::Base
  attr_accessible :amount_cents, :currency, :method, :for, :memo
  belongs_to :student

	before_save { |p| p.amount_cents *= 100 }

 	validates :amount_cents, presence: true
 	validates :currency, presence: true
 	validates :method, presence: true
 	validates :student_id, presence: true
 	validates :for, presence: true
end
