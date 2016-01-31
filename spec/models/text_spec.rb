require 'rails_helper'

describe Text do
  it { should belong_to(:enrollment) }

  it { should have_valid(:text).when(Text.new) }
  it { should_not have_valid(:text).when(nil) }
end
