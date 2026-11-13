class Course < ApplicationRecord
  
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :name, :description, presence: :true
  validates :name, length: { minimum: 5}
  validates :description, length: { minimum: 15 }

  def self.ransackable_attributes(auth_object = nil)
    %w[
      name
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      students
      enrollments
      projects
      student_projects
    ]
  end
end
