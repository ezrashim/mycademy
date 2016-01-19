require 'rails_helper'

describe User do
  it { should have_many(:courses).through(:enrollments) }

  it { should have_valid(:first_name).when("John") }
  it { should_not have_valid(:first_name).when("", nil) }

  it { should have_valid(:last_name).when("Doe") }
  it { should_not have_valid(:last_name).when("", nil) }

  it { should have_valid(:email).when("example@gmail.com") }
  it { should_not have_valid(:email).when("", nil, "John") }

  describe "#admin?" do
    it "is not an admin if the role is not admin" do
      user = create(:user, role: "member")
      expect(user.admin?).to eq(false)
    end

    it "is an admin if the role is admin" do
      user = create(:user, role: "admin")
      expect(user.admin?).to eq(true)
    end
  end
end
