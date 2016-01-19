FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Learning #{n}" }
    sequence(:description) { |n| "This is where the description is written #{n}" }
  end
end
