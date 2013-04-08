class SessionsController < ApplicationController
	def new
	end

	def create
		student = Student.find_by_email(params[:session][:email].downcase)
		if student && student.authenticate(params[:session][:password])
			sign_in(student)
			render 'new' #need to change!!
		else
			flash.now[:error] = 'Oops! Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to '/signin' #need to change!!
	end
end
