require 'rails_helper'

feature 'create a question', %{
  As a leader,
  I should be able to create a question,
  So I can add questions to the course
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can add a question
  # * So I can view the question.
  # * If I am a learner, I cannot add a question.
  # * If I am a visitor, I cannot view the question.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'leader can create a lesson' do
    sign_in_as(leader)
    visit course_lesson_path(course, lesson)
    find('#add-question').click

    fill_in 'Question', with: "Who should become the America's next president?"

    click_button 'Create Question'

    expect(page).to have_content "Who should become the America's next president?"
  end

  scenario 'learner cannot create a lesson' do
    sign_in_as(learner)
    visit course_lesson_path(course, lesson)

    expect(page).to_not have_css '#add-question'
    expect(page).to have_link question.question
  end

  scenario 'visitor cannot view the question' do
    visit course_lesson_path(course, lesson)

    expect(page).to have_content 'Log in'
  end
end
