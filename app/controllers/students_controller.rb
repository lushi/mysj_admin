class StudentsController < ApplicationController
	before_filter :signed_in_check
	before_filter :right_student_check, only: [:edit, :update]

  def new
  end

  def show
  	@student = Student.find(params[:id])
  end

  def edit
  end

  def update
  	if @student.update_attributes(params[:student])
  		flash[:success] = "Settings updated"
  		sign_in @student
  		redirect_to @student
  	else
  		render 'edit'
  	end
  end

  def index
    @students = Student.find_all_by_enrolled_now(true)
  end

  private

  	def signed_in_check
  		redirect_to signin_url, notice: "Please sign in." unless signed_in?
  	end

  	def right_student_check
  		@student = Student.find(params[:id])
  		redirect_to(root_path) unless current_student?(@student)
  	end
end
