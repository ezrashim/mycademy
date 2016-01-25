require 'rails_helper'

describe Course do
  it { should have_many(:enrollments) }
  it { should have_many(:lessons) }

  it { should have_valid(:title).when("Learn to Code") }
  it { should_not have_valid(:title).when("", nil) }
  it { should have_valid(:description).when("I'll teach you how.") }
  it { should_not have_valid(:description).when("", nil) }
  it { should have_valid(:passcode).when("passscode") }
  it { should_not have_valid(:passcode).when("", nil) }
end
