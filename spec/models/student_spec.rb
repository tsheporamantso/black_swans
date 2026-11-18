
require "rails_helper"

RSpec.describe Student, type: :model do

  describe "student" do
    it "should not create student with empty attributes" do
      student = Student.create()

      expect(student.persisted?).to be false
    end
    
    it "should be invalid with incorrect email format" do
      student = build(:student, email: "johndoe.com")

      expect(student).not_to be_valid
      expect(student.errors[:email]).to include("is invalid")
    end

    it "should be invalid with incorrect name format" do
      student = build(:student, first_name: "Tshepo 2")

      expect(student).not_to be_valid
      expect(student.errors[:first_name]).to include("can only contain letters, spaces, hyphens, and apostrophes")
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:first_name).is_at_least(2) }
    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_least(2) }
    it { should allow_value("Tshepo").for(:first_name) }
    it { should_not allow_value("John@Doe").for(:last_name) }
    
  end
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

  describe "callbacks" do
    describe "before_validation" do
      it "should titlelize first_name before validation" do
        student = build(:student, first_name: "tshepo")
        
        student.valid?
        expect(student.first_name).to eq("Tshepo")
      end
    end
    describe "after_validation" do
      it "should log errors after validation" do
        student = build(:student, email: "") 

        expect(Rails.logger).to receive(:error).with(/Validation failed:/).at_least(:once)
        
        student.valid?

        expect(student).not_to allow_value(nil).for(:email)
      end
    end
    describe "after_create" do 
      it "should display student age after create" do
        expect(Rails.logger).to receive(:info).with(/Name titleized to Tshepo/).and_call_original

        expect(Rails.logger).to receive(:info).with(/Student age is 42 years/).and_call_original

      FactoryBot.create(:student, date_of_birth: "1983-12-19")
      end  

      it "should log a warning when date of birth is missing" do
        
        expect(Rails.logger).to receive(:warn).with("Date of birth not provided, cannot calculate age.")

        create(:student)
      end
    end
  end
end
