class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy personal_details ]

  def index
    per_page = 2

    @page = [params[:page].to_i, 1].max

    @total_students = Student.count
    @total_pages = [(@total_students.to_f / per_page).ceil, 1].max

    @page = [@page, @total_pages].min

    offset = (@page - 1) * per_page

    @students = Student.includes(:courses).order(:id).limit(per_page).offset(offset)
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
    @age = @student.student_age
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

  def active
    @student = Student.all
  end

  def personal_details
  end

  private
  
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, :date_of_birth)
  end
end
