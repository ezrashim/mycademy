FactoryGirl.define do
  factory :lesson do
    sequence(:title) { |n| "Lesson #{n}" }
    sequence(:content) { |n| "This is where the contents of this lesson #{n}" }
    sequence(:order_no) { |n| n }
    course
  end
end
