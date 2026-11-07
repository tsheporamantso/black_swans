class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @students = Student.all
  end

  def new 
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = "Student created successfully."
      redirect_to students_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show 
  end

  def edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "Student updated successfully."
      redirect_to student_path(@student)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = "Student deleted successfully."
    redirect_to students_path
  end

  private
  
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number)
  end
end
