require 'rails_helper'

describe Lesson do
  it { should belong_to(:course) }
  it { should have_many(:questions) }

  it { should have_valid(:title).when("Lesson 1") }
  it { should_not have_valid(:title).when("", nil) }
  it { should have_valid(:content).when("A lot of content goes here. A lot. Whatever you want.") }
  it { should_not have_valid(:content).when("", nil) }
  it { should have_valid(:lesson_no).when(1) }
  it { should_not have_valid(:lesson_no).when(nil) }
end
