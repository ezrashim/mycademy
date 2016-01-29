require 'rails_helper'

feature 'view searched courses', %{
  As a user,
  I should be able to view courses that I search,
  So I can choose to sign up.
  } do
  # ACCEPTANCE CRITERIA
  # * As an unauthenticated user, I can view all the courses,
  # * and see a link to 'Join Mycademy'.

    let!(:user) { create(:user) }
    let!(:courses) { create_list(:course, 10) }

  scenario "visitor views courses on index page" do
    visit courses_path

    courses.each do |course|
      expect(page).to have_content(course.title)
      expect(page).to have_content(course.description)
    end

    expect(page).to have_link('Join Mycademy')
  end

  scenario "authenticated user views courses on index page" do
    sign_in_as(user)

    courses.each do |course|
      expect(page).to have_content(course.title)
      expect(page).to have_content(course.description)
    end

    expect(page).to_not have_link('Join Mycademy')
  end
end
