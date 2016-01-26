require 'rails_helper'

feature 'create a course', %{
  As an authenticated user,
  I should be able to create a course,
  So I can view the course created
  } do
  # ACCEPTANCE CRITERIA
  # * As an authenticated user, I can add a course
  # * So that others can view it.

  let!(:user) { create(:user) }

  scenario "authenticated users can create courses" do
    sign_in_as(user)
    click_link("Lead")
    fill_in("Title", with: "Math")
    fill_in("Description", with: "All about math")
    fill_in("Passcode", with: "passcode")
    click_button("Create Course")

    expect(page).to have_content("Math")
    expect(page).to have_content("All about math")
  end

end
