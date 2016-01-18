FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name) { |n| "Doe#{n}" }
    sequence(:email) { |n| "johnsmith#{n}@gmail.com" }
    password "password"
    password_confirmation "password"
  end
end
