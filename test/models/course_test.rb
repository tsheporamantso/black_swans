require "test_helper"

class CourseTest < ActiveSupport::TestCase

  def assert_course_invalid(course)
    assert_not course.save
    assert_predicate course.errors, :any?
  end

  test "should not be valid with empty name and description" do
    course = Course.new

    assert_course_invalid(course)
  end

  test "should be invalid with incorrect length" do
    name = "a" * 3
    description = "b" * 14

    course = Course.new(name: name, description: description)

    assert_course_invalid(course)
  end

  test "should create course" do
    name = "a" * 6
    description = "b" * 16

    course = Course.new(name: name, description: description )

    assert(course.save, ["Course will be created"])
  end
end
