FactoryGirl.define do
  factory :question do
    sequence(:description) { |n| "Question #{n}" }
    lesson
  end
end
