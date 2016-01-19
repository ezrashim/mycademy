FactoryGirl.define do
  factory :enrollment do
    role "learner"
    user
    course
  end
end
