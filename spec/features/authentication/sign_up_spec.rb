require 'rails_helper'

feature 'sign up', %{
  As a prospective user
  I want to create an account
  So that I can create or join courses.
  } do
  # ACCEPTANCE CRITERIA
  # * I must specify a valid email address.
  # * I must specify a password, and confirm that password.
  # * If I do not perform the above, I get an error message.
  # * If I specify valid information,
  # * I register my account and am authenticated.

  scenario 'specifying valid and required information' do
    visit root_path
    click_link 'Join Mycademy'
    fill_in('First Name', with: 'John')
    fill_in('Last Name', with: 'Doe')
    fill_in('Email', with: 'johndoe@123.com')
    fill_in('Password', with: 'Seekrit123')
    fill_in('Password confirmation', with: 'Seekrit123')
    click_button('Sign Up')

    expect(page).to have_content("Welcome! You are signed in.")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Join Mycademy'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match confirmation' do
    visit root_path
    click_link 'Join Mycademy'

    fill_in 'Password', with: '123Seekrit'
    fill_in 'Password confirmation', with: '756Seekrit'
    click_button 'Sign Up'

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end
end
