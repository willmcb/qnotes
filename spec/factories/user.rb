FactoryBot.define do
  factory :user do
    username { "testuser" }
    email { "testuser@test.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
