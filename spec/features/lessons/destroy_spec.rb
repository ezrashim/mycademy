require 'rails_helper'

feature 'destroy a lesson', %{
  As a leader,
  I should be able to destroy a lesson,
  So nobody can view the lesson
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader of the course, I can delete a lesson
  # * So that others cannot view.
  # * If I am a learner, I cannot delete a lesson.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario "leader can delete the lesson" do
    lesson = course.lessons.first
    sign_in_as(leader)
    visit course_lesson_path(course, lesson)

    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.content
    find('#delete-lesson').click

    expect(page).to_not have_content lesson.title
    expect(page).to have_content course.title
    expect(page).to have_content course.description
    expect(page).to have_css '#add-lesson'
  end

  scenario "learner cannot delete the course" do
    lesson = course.lessons.first
    sign_in_as learner
    visit course_lesson_path(course, lesson)

    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.content
    expect(page).to_not have_css '#delete-lesson'
  end
end
