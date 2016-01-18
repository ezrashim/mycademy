require 'rails_helper'

feature 'sign out', %{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten on the machine i am using
  } do
  # ACCEPTANCE CRITERIA
  # * if i am signed in, i have an option to sign out
  # * when i am opted to sign out, i get a confirmation that my identity
  # * has beed forgotten on the machine i am using

  scenario 'authenticated user signs out' do
    user = create(:user)
    sign_in_as(user)

    expect(page).to have_content("Signed in successfully.")
    click_link "Sign Out"
    expect(page).to have_content("Signed out successfully.")
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit root_path

    expect(page).to_not have_content("Sign Out")
  end
end
