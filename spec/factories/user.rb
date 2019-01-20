FactoryBot.define do
  factory :user do
    user_name { "Test" }
    email { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
