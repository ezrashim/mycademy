require 'rails_helper'

describe Question do
  it { should belong_to(:lesson) }

  it { should have_valid(:description).when("First Question") }
  it { should_not have_valid(:description).when("", nil) }
  it { should have_valid(:lesson_id).when(1) }
  it { should_not have_valid(:lesson_id).when(nil)}
end
