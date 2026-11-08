class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  has_many :student_projects, dependent: :destroy
  has_many :projects, through: :student_projects

  validates :first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, presence: :true
end
