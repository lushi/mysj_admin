class StudentsController < ApplicationController
	before_filter :signed_in_check
	before_filter :right_student_check, only: [:edit, :update]
  before_filter :admin_check, only: [:new, :create, :destroy, :index]

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
    @student = params[:id] ? Student.find(params[:id]) : current_student
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
    @students = Student.all
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    flash[:success] = "#{student.given_name} #{student.surname} has been deleted."
    redirect_to students_url
  end

  private

    def right_student_check
      @student = Student.find(params[:id])
      redirect_to(root_path) unless current_student?(@student)
    end
end