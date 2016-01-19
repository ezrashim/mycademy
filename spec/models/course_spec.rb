require 'rails_helper'

describe Course do
  it { should have_many(:enrollments) }

  it { should have_valid(:title).when("Learn to Code") }
  it { should_not have_valid(:title).when("", nil) }

end
