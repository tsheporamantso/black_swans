module Validatable
  extend ActiveSupport::Concern

  included do 
    validates :first_name, :last_name, :email, :permanent_address, :local_address, :permanent_contact_number, :alternative_contact_number, presence: :true
    validates :email , uniqueness: :true
    validates :first_name, :last_name, length: { minimum: 2, maximum: 50 }, format: {with: /\A[\p{L}\s\-']+\z/, message: "can only contain letters, spaces, hyphens, and apostrophes"}
  end
end