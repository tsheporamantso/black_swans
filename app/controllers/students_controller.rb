class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy personal_details ]
  before_action :authenticate_admin_user!

  def index
    per_page = 2

    @q = Student.ransack(params[:q])

    students = @q.result(distinct: true)

    @total_students = students.count
    @total_pages = [(@total_students.to_f / per_page).ceil, 1].max

    @page = [[params[:page].to_i, 1].max, @total_pages].min

    offset = (@page - 1) * per_page

    @students = students
                .includes(:courses)
                .order(:id)
                .limit(per_page)
                .offset(offset)
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
      render :new, status: :unprocessable_content
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
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = "Student deleted successfully."
    redirect_to students_path
  end

  def active_students
    @student = Student.all
  end

  def personal_details
  end

  private
  
  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, :date_of_birth, :profile_image)
  end
end
