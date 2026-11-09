class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  has_many :student_projects, dependent: :destroy
  has_many :projects, through: :student_projects

  validates :first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, presence: :true

  before_validation :titleize_first_name
  after_validation :log_errors

  private
  def titleize_first_name
    self.first_name = first_name.titleize if first_name.present?
    Rails.logger.info("Name titleized to #{first_name}")
  end

  def log_errors
    if errors.any?
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}")
    end
  end
end
