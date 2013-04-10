class StudentsController < ApplicationController
	before_filter :signed_in_check
	before_filter :right_student_check, only: [:edit, :update]
  before_filter :admin_check, only: [:new, :create, :destroy]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:success] = "#{@student.given_name} is now a student!"
      redirect_to @student
    else
      render 'new'
    end
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

  def destroy
    student = Student.find(params[:id])
    student.destroy
    flash[:success] = "#{student.given_name} #{student.surname} has been deleted."
    redirect_to students_url
  end

  private

  	def signed_in_check
      unless signed_in?
        store_location
    		redirect_to signin_url, notice: "Please sign in."
      end
  	end

  	def right_student_check
  		@student = Student.find(params[:id])
  		redirect_to(root_path) unless current_student?(@student)
  	end

    def admin_check
      redirect_to(root_path) unless current_student.admin?
    end
end
