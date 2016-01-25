FactoryGirl.define do
  factory :course do
    sequence(:title) { |n| "Learning #{n}" }
    sequence(:description) { |n| "This is where the description is written #{n}" }
    passcode "passcode"

    factory :course_with_lessons do
      after(:create) do |new_course|
        FactoryGirl.create_list(:lesson, 5, course: new_course)
      end
    end
  end
end
