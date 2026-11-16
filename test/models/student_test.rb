require "test_helper"

class StudentTest < ActiveSupport::TestCase
  
  def assert_student_invalid(student)
    assert_not student.save
    assert_predicate student.errors, :any?
  end

  test "should not create student without attributes" do
    student = Student.new

    assert_student_invalid(student)
  end

  test "should not create student with minimum length of 2 on first_name and last_name" do
    student = Student.new(first_name: "A", last_name: "B")
    
    assert_student_invalid(student)
  end

  test "should not create student with incorrect email format" do
    student = Student.new(email: "johnDoe.com")

    assert_student_invalid(student)
  end

  test "should create student when all attributes are present" do
    
    student = Student.new(
      first_name: "John", 
      last_name: "Doe", 
      email: "john.doe@example.com", 
      permanent_address: "2157 Makutso str rockville", 
      local_address: "Roodeport", 
      permanent_contact_number: "1234567890", 
      alternative_contact_number: "1234567890" 
    ) 
  
    assert student.save
  end
end
