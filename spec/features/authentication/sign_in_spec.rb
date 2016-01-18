require 'rails_helper'

feature 'sign in', %{
  As an unauthenticated user
  I want to sign in
  So that I can create or join courses
  } do
  # ACCEPTANCE CRITERIA
  # * I must enter a user's email address
  # * I must enter a user's password
  # * If I do not perform the above, I get an error message
  # * If I specify valid information,
  #   I sign in to my account and am authenticated.

  scenario 'an existing user specifies a valid email and password' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'a nonexistent email and password is supplied' do
    visit new_user_session_path
    fill_in 'Email', with: 'nonexistent'
    fill_in 'Password', with: 'nonexistent'
    click_button 'Log in'

    expect(page).to have_content("Invalid email or password.")
    expect(page).to have_content("Sign Up")
  end

  scenario 'an existing email with the wrong password is denied access' do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'random'
    click_button 'Log in'

    expect(page).to have_content("Invalid email or password.")
    expect(page).to have_content("Sign Up")
  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = create(:user)
    visit root_path
    sign_in_as(user)

    expect(page).to_not have_content('Sign In')
  end
end
