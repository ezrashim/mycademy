require 'rails_helper'

feature 'view questions', %{
  As a leader,
  I should be able to view questions in each lesson,
  So I can review questions for the lesson
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can view questions
  # * So I can review them.
  # * If I am a learner, I can view the questions.
  # * If I am a visitor, I cannot view the question.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end
  let!(:learner_enrollment) do
    create :enrollment, role: 'learner', user: learner, course: course
  end

  scenario 'a leader can view links to questions' do
    sign_in_as leader
    visit questions_path(lesson_id: lesson.id)

    expect(page).to have_link(question.question)
  end

  scenario 'a learner can view the list of questions for the lesson' do
    sign_in_as learner
    visit questions_path(lesson_id: lesson.id)

    expect(page).to have_link(question.question)
  end

  scenario 'a visitor cannot view the list of questions' do
    visit questions_path(lesson_id: lesson.id)

    expect(page).to have_content 'Log in'
  end
end
