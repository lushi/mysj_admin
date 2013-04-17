class PaymentsController < ApplicationController
	helper_method :sort_column, :sort_direction

	before_filter :signed_in_check
	before_filter :admin_check, only: [:new, :create, :destroy]


	def new
		@payment = Payment.new
		@students = Student.order("given_name ASC").find_all_by_enrolled_now(true)
	end

	def create
		@student = Student.find_by_id(params[:student_id])
		@payment = @student.payments.build(params[:payment])
		if @payment.save
			flash[:success] = "Payment record for #{@student.given_name} added!"
      redirect_to new_payment_url
    else
    	@students = Student.find_all_by_enrolled_now(true)
      render 'new'
    end
	end

	def index
		if current_student.admin?
			@payments = Payment.joins(:student).order(sort_column + " " + sort_direction)
		else
			@payments = current_student.payments.joins(:student).order(sort_column + " " + sort_direction)
		end
	end

	def destroy
		payment = Payment.find(params[:id])
		payment.destroy
		flash[:success] = "Record deleted."
		redirect_to payments_url
	end

	private
		def sort_column
			column_names = Payment.column_names + ["given_name", "surname"]
			column_names.include?(params[:sort]) ? params[:sort] : "created_at"
		end

		def sort_direction
			["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
		end
end
