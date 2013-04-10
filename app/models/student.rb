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
#  auth_token      :string(255)
#  sex             :string(255)
#  date_of_birth   :date
#  occupation      :string(255)
#  street          :string(255)
#  city            :string(255)
#  state           :string(255)
#  zipcode         :string(255)
#  country         :string(255)
#  shirt_size      :string(255)
#  pants_size      :string(255)
#  shoe_size       :string(255)
#  status          :string(255)
#  generation      :integer
#  concentration   :string(255)
#  enrolled_now    :boolean
#  home_phone      :string(255)
#  cell_phone      :string(255)
#

class Student < ActiveRecord::Base
  attr_accessible(:given_name, :surname, :email, :password, :password_confirmation,
                  :sex, :date_of_birth, :occupation, :street, :city, :state, :zipcode,
                  :country, :shirt_size, :pants_size, :shoe_size, :status,
                  :generation, :concentration, :enrolled_now, :home_phone, :cell_phone)

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
