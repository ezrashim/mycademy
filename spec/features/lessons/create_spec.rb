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

    expect(page).to have_css '#add-lesson'

    find('#add-lesson').click

    fill_in 'Title', with: "froala is awesome!!!"
    fill_in 'froala-editor', with: "let's see how this turns out!!!"

    click_button 'Create Lesson'

    expect(page).to have_content "froala is awesome!!!"
    expect(page).to have_content "let's see how this turns out!!!"
  end

  scenario 'learner cannot create a lesson' do
    sign_in_as(learner)
    visit course_path(course)

    expect(page).to_not have_css '#add-lesson'
    expect(page).to have_content 'My Progress'
  end

  scenario 'visitor cannot create a lesson' do
    sign_in_as(user)
    visit course_path(course)

    expect(page).to_not have_content 'Create Lesson'
    expect(page).to have_content 'Join Course'
  end

  scenario 'unauthenticated user cannot create a lesson' do
    visit course_path(course)

    expect(page).to_not have_content 'Create Lesson'
    expect(page).to have_content 'Join Mycademy'
  end

  scenario 'visitor cannot create a lesson via url' do
    sign_in_as(user)
    visit new_course_lesson_path(course)

    expect(page).to_not have_content 'Content'
  end
end
