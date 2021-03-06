module SessionsHelper

	def sign_in(student)
		if params[:session] && params[:session][:remember_me] == "1"
			cookies.permanent[:auth_token] = student.auth_token
		else
			cookies[:auth_token] = student.auth_token
		end
		self.current_student = student
	end

	def signed_in?
		!current_student.nil?
	end

	def current_student=(student)
		@current_student = student
	end

	def current_student
		@current_student ||= Student.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
	end

	def current_student?(student)
		student == current_student
	end

	def sign_out
		self.current_student = nil
		cookies.delete(:auth_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end

	def signed_in_check
	  unless signed_in?
	    store_location
			redirect_to signin_url, notice: "Please sign in."
	  end
	end

	def admin_check
	  redirect_to(root_path) unless current_student.admin?
	end
end