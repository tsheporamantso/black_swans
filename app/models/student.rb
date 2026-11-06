class Student < ApplicationRecord
  validates :first_name, :last_name, :email, :permanent_address, :local_address, presence: :true
end
