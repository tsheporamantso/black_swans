class Course < ApplicationRecord
  paginates_per 2

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :name, :description, presence: :true
  validates :name, length: { minimum: 5}
  validates :description, length: { minimum: 15 }
end
