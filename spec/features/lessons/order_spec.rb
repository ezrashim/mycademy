require 'rails_helper'

feature 'reorder a lesson', %{
  As a leader of the course,
  I should be able to change the order of a lesson,
  So learners can view the changed order of lessons.
} do
  # ACCEPTANCE CRITERIA
  # * As a leader of the course, I can update the order_no attribute of lessons,
  # * So that learners can see changed order of the lessons.
  # * If I am a learner, I cannot see the order_no button.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson_1) { create :lesson, lesson_no: 1, course: course }
  let!(:lesson_2) { create :lesson, lesson_no: 2, course: course }
  let!(:lesson_3) { create :lesson, lesson_no: 3, course: course }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'leader can move the first lesson to be second in order' do
    sign_in_as(leader)
    visit course_path(course)

    expect(page).to have_content("1. #{lesson_1.title}")

    first(:css, '.down').click
    expect(page).to have_content("#{leader.first_name},
      you want that lesson to be later, eh? Good thinking.")
    expect(page).to have_content("2. #{lesson_1.title}")
  end

  scenario 'nothing happens if the leader tries to move the last lesson down' do
    sign_in_as leader
    visit course_path(course)
    all('.down').last.click

    expect(page).to have_content("3. #{lesson_3.title}")
  end

  scenario 'leader can move the second lesson to be first in order' do
    sign_in_as(leader)
    visit course_path(course)

    expect(page).to have_content("2. #{lesson_2.title}")

    all('.up')[1].click

    expect(page).to have_content("#{leader.first_name},
      you want that lesson to be sooner, eh? Wise choice.")
    expect(page).to have_content("1. #{lesson_2.title}")
  end

  scenario 'nothing happens if the leader tries to move the first lesson up' do
    sign_in_as leader
    visit course_path(course)
    first(:css, '.up').click

    expect(page).to have_content("1. #{lesson_1.title}")
  end
end
