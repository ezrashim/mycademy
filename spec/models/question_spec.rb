require 'rails_helper'

describe Question do
  it { should belong_to(:lesson) }

  it { should have_valid(:question).when("What did you learn?") }
  it { should_not have_valid(:question).when("", nil) }
end
