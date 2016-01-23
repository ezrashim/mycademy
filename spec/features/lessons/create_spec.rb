require 'rails_helper'

feature 'create a lesson', %{
  As a leader,
  I should be able to create a lesson,
  So I can add lessons to the course
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can add a lesson
  # * So I can view the lesson.
  # * If I am a learner, I cannot add a lesson.
  # * If I am a visitor, I cannot view the lesson.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'leader can create a lesson' do
    sign_in_as(leader)
    visit course_path(course)
    click_link 'Add Lesson'

    fill_in 'Title', with: "froala is awesome!!!"
    fill_in 'Content', with: "let's see how this turns out!!!"

    click_button 'Create Lesson'

    expect(page).to have_content "froala is awesome!!!"
    expect(page).to have_content "let's see how this turns out!!!"
  end
end
