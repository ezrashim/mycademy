require 'rails_helper'

feature 'view all courses', %{
  As a user,
  I should be able to view all courses,
  So I can choose to sign up
  } do
  # ACCEPTANCE CRITERIA
  # * As an unauthenticated user, I can view all the courses,
  # * and see a link to 'Join Mycademy'.

    let!(:user) { create(:user) }
    let!(:courses) { create_list(:course, 10) }

  scenario "visitor views join mycademy" do
    visit root_path

    expect(page).to have_link('Join Mycademy')
    expect(page).to have_content('Search Course')
  end

  scenario "authenticated user views courses on index page" do
    sign_in_as(user)

    expect(page).to have_content('Search Course')
    expect(page).to_not have_link('Join Mycademy')
  end
end
