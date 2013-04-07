# == Schema Information
#
# Table name: students
#
#  id              :integer          not null, primary key
#  surname         :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  given_name      :string(255)
#

class Student < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |s| s.email = email.downcase }

  validates :name,
  	presence: true,
  	length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
  	presence: true,
  	format: { with: VALID_EMAIL_REGEX },
  	uniqueness: true

  validates :password,
  	presence: true,
  	length: { minimum: 8 }

  validates :password_confirmation,
  	presence: true
end
