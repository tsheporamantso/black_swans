class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  has_many :student_projects, dependent: :destroy
  has_many :projects, through: :student_projects

  include Validatable
  
  before_validation :titleize_first_name
  after_validation :log_errors
  after_create :display_student_age

  def self.ransackable_attributes(auth_object = nil)
    %w[
      first_name
      last_name
      email
      permanent_contact_number
      alternative_contact_number
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[
      courses
      enrollments
      projects
      student_projects
    ]
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def student_age
    return "Date of Birth not provided" unless date_of_birth.present?
    return ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

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

  def display_student_age
    if date_of_birth.present?
      age = ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
      Rails.logger.info("Student age is #{age} years")
    else
      Rails.logger.warn("Date of birth not provided, cannot calculate age.")
    end
  end
end
