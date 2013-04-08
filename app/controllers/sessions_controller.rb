class SessionsController < ApplicationController
	def new
		if signed_in?
			redirect_to "/students/#{current_student.id}" #NEED TO CHANGE!!! SHOULD ONLY BE ABLE TO VIEW OWN PROFILE
		end
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
