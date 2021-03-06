require 'rails_helper'

feature 'view lessons', %{
  As a leader,
  I should be able to view lessons in each course,
  So I can review lessons for the course
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can view lessons
  # * So I can review them.
  # * If I am a learner, I cannot view the lesson.
  # * If I am a visitor, I cannot view the lesson.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'visitors can view links to lessons' do
    visit course_path(course)

    expect(page).to have_content(course.lessons.first.title)
  end

  scenario 'visitor can click links and lead to join page' do
    visit course_path(course)
    expect(page).to have_content course.lessons.first.title

    click_link 'Join Mycademy'

    expect(page).to have_content 'Sign up'
    expect(page).to have_content 'First Name'
    expect(page).to have_content 'Last Name'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  scenario 'learner can view links to lessons' do
    sign_in_as(learner)
    visit course_path(course)

    expect(page).to have_content(course.lessons.first.title)
  end

  scenario 'learner can click links and lead to lessons page' do
    lesson = course.lessons.first
    sign_in_as(learner)
    visit course_path(course)
    click_link(lesson.title)

    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.content
  end

  scenario 'user can view lesson titles' do
    lesson = course.lessons.first
    sign_in_as(user)
    visit course_path(course)

    expect(page).to have_content(lesson.title)
  end

  scenario 'user can click links and flash shows on the page' do
    sign_in_as(user)
    visit course_path(course)

    expect(page).to have_content 'Join Course'
  end

  scenario 'leader can view links to lessons' do
    lesson = course.lessons.first
    sign_in_as(leader)
    visit course_path(course)

    expect(page).to have_content(lesson.title)
  end

  scenario 'leader can click links and can view create and update links to each lesson.' do
    lesson = course.lessons.first
    sign_in_as(leader)
    visit course_path(course)

    expect(page).to have_link lesson.title
    expect(page).to have_css '#add-lesson'
  end
end
