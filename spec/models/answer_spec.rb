require 'rails_helper'

describe Answer do
  it { should belong_to(:question) }
  it { should belong_to(:enrollment) }

  it { should have_valid(:question).when(Question.new) }
  it { should_not have_valid(:question).when(nil) }
  it { should have_valid(:enrollment).when(Enrollment.new) }
  it { should_not have_valid(:enrollment).when(nil) }
  it { should have_valid(:answer).when("This is an answer.") }
  it { should_not have_valid(:answer).when("", nil) }
end
