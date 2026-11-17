FactoryBot.define do
  factory :student do
    first_name { "Tshepo" }
    last_name { "Ramantso" }
    sequence(:email) { |n| "tshepo#{n}@example.com" }
    permanent_address { "123 Main Street, Soweto" }
    local_address { "456 Campus Road, Johannesburg" }
    permanent_contact_number { "0712345678" }
    alternative_contact_number { "0823456789" }
  end
end
