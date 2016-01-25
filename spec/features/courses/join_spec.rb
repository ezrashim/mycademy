require 'rails_helper'

feature 'join a course', %{
  As a visitor,
  I should be able to join a course upon entering passcode,
  So I can be enrolled in a course.
} do
  # ACCEPTANCE CRITERIA
  # * As a visitor, I can enter passcode for the course.
  # * If the passcode matches the course, enrollment as a learner is created.
  # * If the passcode does not match the course, I am denied of access.
  # * As a learner, I have a link to the desired course in my progress page.

  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons, passcode: "passcode" }

  scenario 'visitors can join their desired course by entering passcode' do
    sign_in_as user
    visit course_path(course)
    click_link 'Join Course'

    expect(page).to have_field('Passcode')

    fill_in 'Passcode', with: 'passcode'
    click_button 'Join'

    expect(page).to have_content("Welcome to #{course.title}!
    You are now enrolled!")
    expect(page).to have_content course.title
    expect(page).to have_content course.description
    expect(page).to have_link course.lessons.first.title
  end
end
