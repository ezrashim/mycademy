require 'rails_helper'

feature 'learners can view each question question', %{
  As a learner,
  I should be able to view the question of the question,
  So I can answer the question.
  } do
  # ACCEPTANCE CRITERIA
  # * As a learner or a leader, I can view the question of the question.
  # * As an authenticated user, I cannot view the question.
  # * As a visitor, I cannot view the question.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course}
  let!(:question) { create :question, lesson: lesson }
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end
  let!(:learner_enrollment) do
    create :enrollment, role: 'learner', user: learner, course: course
  end

  scenario 'learner can view the question' do
    sign_in_as(learner)
    visit question_path(question)

    expect(page).to have_content question.question
  end

  scenario 'leader can view the question' do
    sign_in_as(leader)
    visit question_path(question)

    expect(page).to have_content question.question
  end

  scenario 'user cannot view the question' do
    sign_in_as(user)
    visit question_path(question)

    expect(page).to have_content 'Passcode'
  end

  scenario 'unauthenticated user cannot view the question' do
    visit question_path(question)

    expect(page).to have_content 'Log in'
  end
end
