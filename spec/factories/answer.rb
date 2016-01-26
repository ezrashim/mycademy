FactoryGirl.define do
  factory :answer do
    sequence(:answer) { |n| "This is the answer #{n}" }
    enrollment
    question
  end
end
