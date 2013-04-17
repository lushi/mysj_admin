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
#  status          :string(255)      default("student")
#  generation      :integer          default(1)
#  concentration   :string(255)      default("wing chun")
#  enrolled_now    :boolean          default(TRUE)
#  home_phone      :string(255)
#  cell_phone      :string(255)
#  admin           :boolean          default(FALSE)
#

require 'spec_helper'

describe Student do

	before(:each) do
		@student = Student.new(
			given_name: "Joe",
			surname: "Smith",
			email: "jsmith@example.com",
			password: "foobar12",
			password_confirmation: "foobar12"
			)
	end

	subject { @student }

	it { should respond_to(:given_name) }
	it { should respond_to(:surname) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:password_digest) }
  it { should respond_to(:auth_token) }
	it { should respond_to(:authenticate) }
  it { should respond_to(:date_of_birth) }
  it { should respond_to(:sex) }
  it { should respond_to(:occupation) }
  it { should respond_to(:street) }
  it { should respond_to(:city) }
  it { should respond_to(:state) }
  it { should respond_to(:zipcode) }
  it { should respond_to(:country) }
  it { should respond_to(:shirt_size) }
  it { should respond_to(:pants_size) }
  it { should respond_to(:shoe_size) }
  it { should respond_to(:concentration) }
  it { should respond_to(:status) }
  it { should respond_to(:generation) }
  it { should respond_to(:enrolled_now?) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:payments) }
  it { should respond_to(:payment_plans) }

	it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @student.save!
      @student.toggle!(:admin)
    end

    it { should be_admin }
  end

	describe "when given_name is not present" do
		before { @student.given_name = " "}
		it { should_not be_valid }
	end

	describe "when surname is not present" do
		before { @student.surname = " "}
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @student.email = " "}
		it { should_not be_valid }
	end

	describe "when given_name is too long" do
		before { @student.given_name = "a" * 26 }
		it { should_not be_valid }
	end

	describe "when surename is too long" do
		before { @student.surname = "a" * 26 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
      addresses = %w[student@foo,com user_at_foo.org example.student@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @student.email = invalid_address
        @student.should_not be_valid
      end
    end
  end

  describe "when email is already taken" do
  	before do
  		student_same_email = @student.dup
  		@student.email.upcase!
  		student_same_email.save
  	end
  	it {should_not be_valid }
  end

  describe "when password is not present" do
  	before { @student.password = @student.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @student.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
  	before { @student.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "with a password that's too short" do
  	before { @student.password = @student.password_confirmation = "a" * 5 }
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @student.save }
  	let(:found_user) { Student.find_by_email(@student.email) }

  	describe "with valid password" do
  		it { should == found_user.authenticate(@student.password) }
  	end

  	describe "with invalid password" do
  		let(:student_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not == student_for_invalid_password }
  		specify { student_for_invalid_password.should be_false }
  	end
  end

  describe "remember token" do
    before { @student.save }
    its(:auth_token) { should_not be_blank }
  end

  describe "payment_plan associations" do
    let(:payment_plan) { FactoryGirl.create(:payment_plan) }
    before do
      @student.save
      @student.payment_plans << payment_plan
      @student.payment_plans << payment_plan
    end

    it "should be joined with payment_plans" do
      @student.payment_plans.should be_include(payment_plan)
    end

    it "should allow diplicates of students and payment_plans" do
      @student.payment_plans.count.should == 2
    end

    it "should destroy associated payment plan choice, but not payment plan" do
      payment_plan_choices = @student.payment_plan_choices.dup
      payment_plans = @student.payment_plans.dup
      @student.destroy
      payment_plan_choices.each do |choice|
        PaymentPlanChoice.find_by_id(choice.id).should be_nil
      end
      payment_plans.each do |plan|
        PaymentPlan.find_by_id(plan.id).should_not be_nil
      end
    end
    describe "when link between student and a payment plan is deleted" do
      before do
        @student.payment_plans.delete(payment_plan)
      end

      it "should not delete associated records in students" do
        Student.find_by_email(@student.email).should_not be_nil
      end
    end
  end


  describe "payments associations" do
    before { @student.save }
    let!(:older_payment) do
      FactoryGirl.create(:payment, student: @student, created_at: 1.year.ago)
    end
    let!(:newer_payment) do
      FactoryGirl.create(:payment, student: @student, created_at: 1.month.ago)
    end

    it "should have the payments in the right (descending) order" do
      @student.payments.should == [newer_payment, older_payment]
    end
  end
end
