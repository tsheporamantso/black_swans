class Student < ApplicationRecord
  validates :first_name, :last_name, :email, :permanent_address, :date_of_birth, presence: true
end
