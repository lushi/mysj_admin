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
  attr_accessible :given_name, :surname, :email, :password, :password_confirmation
  has_secure_password

  before_save { |s| s.email = email.downcase }
  before_save :create_auth_token

  validates :given_name,
  	presence: true,
  	length: { maximum: 25 }

  validates :surname,
    presence: true,
    length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
  	presence: true,
   	format: { with: VALID_EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }

  validates :password,
  	presence: true,
  	length: { minimum: 8 }

  validates :password_confirmation,
  	presence: true

  private
    def create_auth_token
      begin
        self.auth_token = SecureRandom.urlsafe_base64
      end while Student.exists?(auth_token: self.auth_token)
    end
end
