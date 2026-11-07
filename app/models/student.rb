class Student < ApplicationRecord
validates :first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, presence: :true
end
