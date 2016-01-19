require 'rails_helper'

feature 'view all courses', %{
  As a user,
  I should be able to view all courses,
  So I can choose to sign up
  } do
  # ACCEPTANCE CRITERIA
  # * As an unauthenticated user, I can view all the courses,
  # * but I cannot view either button 'I want in!' or 'Create Course'.
  # * Instead, I see a link to 'Create Account'.

  scenario "visitor views courses on index page" do
    courses = create_list(:course, 10)
    visit root_path

    courses.each do |course|
      expect(page).to have_content(course.title)
      expect(page).to have_content(course.description)
    end

      expect(page).to have_link('Join Mycademy')
  end
end
