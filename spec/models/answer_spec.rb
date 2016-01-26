require 'rails_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should belong_to(:enrollment) }

  it { should have_valid(:question_id).when(1) }
  it { should_not have_valid(:question_id).when(nil) }
  it { should have_valid(:enrollment_id).when(1) }
  it { should_not have_valid(:enrollment_id).when(nil) }
  it { should have_valid(:answer).when("My answer is awesome!!!") }
  it { should_not have_valid(:answer).when("", nil) }
end
