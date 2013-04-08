class StudentsController < ApplicationController
  def new
  end

  def show
  	@student = Student.find(params[:id])
  end
end
