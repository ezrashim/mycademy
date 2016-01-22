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

  scenario 'visitors can view links to lessons' do
    visit root_path
    click_link(course.title)

    expect(page).to have_content(course.lessons.first.title)
  end

  scenario 'visitor can click links and lead to join page' do
    visit root_path
    click_link(course.title)
    click_link(course.lessons.first.title)

    expect(page).to have_content 'Sign up'
    expect(page).to have_content 'First Name'
    expect(page).to have_content 'Last Name'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  scenario 'learner can view links to lessons' do
    sign_in_as(learner)
    click_link(course.title)

    expect(page).to have_content(course.lessons.first.title)
  end

  scenario 'learner can click links and lead to lessons page' do
    lesson = course.lessons.first
    sign_in_as(learner)
    click_link(course.title)
    click_link(lesson.title)

    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.content
  end

  scenario 'user can view links to lessons' do
    lesson = course.lessons.first
    sign_in_as(user)
    click_link(course.title)

    expect(page).to have_content(lesson.title)
  end

  scenario 'user can click links and flash shows on the page' do
    lesson = course.lessons.first
    sign_in_as(user)
    click_link(course.title)

    expect(page).to have_content "Yo, sorry. You gotta join the team first."
    expect(page).to have_content 'Join Course'
  end

  scenario 'leader can view links to lessons' do
    lesson = course.lessons.first
    sign_in_as(leader)
    click_link(course.title)

    expect(page).to have_content(lesson.title)
  end

  scenario 'leader can click links and can view create and update links to each lesson.' do
    lesson = course.lessons.first
    sign_in_as(leader)
    click_link(course.title)

    expect(page).to have_link lesson.title
    expect(page).to have_link 'Create Lessons'
  end
end
