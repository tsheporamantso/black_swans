
require "rails_helper"

RSpec.describe Student, type: :model do
  describe "associations" do
    it { should have_many(:enrollments).dependent(:destroy) }

    it { should have_many(:courses).through(:enrollments) }

    it { should have_many(:student_projects).dependent(:destroy) }

    it { should have_many(:projects).through(:student_projects) }
  end

  describe "enrollment associations" do
    let(:student) { create(:student) }
    let(:course) { create(:course) }

    it "can have multiple enrollments" do
      course_2 = create(:course, name: "Ruby Programming",
                                 description: "Learn Ruby programming")

      create(:enrollment, student: student, course: course)
      create(:enrollment, student: student, course: course_2)

      expect(student.enrollments.count).to eq(2)
    end

    it "can access courses through enrollments" do
      create(:enrollment, student: student, course: course)

      expect(student.courses).to include(course)
    end

    it "destroys enrollments when student is destroyed" do
      create(:enrollment, student: student, course: course)

      expect {
        student.destroy
      }.to change(Enrollment, :count).by(-1)
    end
  end
end
