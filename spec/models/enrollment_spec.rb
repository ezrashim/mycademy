require 'rails_helper'

describe Enrollment do
  it { should belong_to(:user) }
  it { should belong_to(:course) }

  it { should have_valid(:user).when(User.new) }
  it { should_not have_valid(:user).when(nil) }

  it { should have_valid(:course).when(Course.new) }
  it { should_not have_valid(:course).when(nil) }

  describe "#leader?" do
    it "is not a leader if the role is not leader" do
      enrollment = create(:enrollment)
      expect(enrollment.leader?).to eq(false)
    end

    it "is an leader if the role is leader" do
      enrollment = create(:enrollment, role: "leader")
      expect(enrollment.leader?).to eq(true)
    end
  end

  describe "#learner?" do
    it "is not an learner if the role is not learner" do
      enrollment = create(:enrollment, role: "leader")
      expect(enrollment.learner?).to eq(false)
    end

    it "is an learner if the role is learner" do
      enrollment = create(:enrollment)
      expect(enrollment.learner?).to eq(true)
    end
  end

end
