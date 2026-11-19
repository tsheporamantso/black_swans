FactoryBot.define do
  factory :admin_user do
    email { "john.doe@example.com" }
    password { "password123" }
    confirmed_at { Time.current }
  end
end
