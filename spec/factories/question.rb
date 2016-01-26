FactoryGirl.define do
  factory :question do
    sequence(:question) { |n| "Question #{n}" }
    lesson
  end
end
