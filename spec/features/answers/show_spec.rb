require 'rails_helper'

feature 'learners and leaders can view answers for each question', %{
  As a learner,
  I should be able to view the answer for the question,
  So I can check the answers.
} do
  # ACCEPTANCE CRITERIA
  # * As a learner or a leader, I can view the answer for each question.
  # * As an authenticated user, I cannot view the answer.
  # * As a visitor, I cannot view the answer.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }
  let!(:answer) { create :answer, enrollment: learner_enrollment, question: question}
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end
  let!(:learner_enrollment) do
    create :enrollment, role: 'learner', user: learner, course: course
  end

  scenario 'learner can view the answer' do
    sign_in_as(learner)
    visit question_answer_path(question, answer)

    expect(page).to have_content question.question
    expect(page).to have_content answer.answer
  end

  scenario 'leader can view the answer' do
    sign_in_as(leader)
    visit question_answer_path(question, answer)

    expect(page).to have_content question.question
    expect(page).to have_content answer.answer
  end

  scenario 'authenticated user cannot view the answer' do
    sign_in_as(user)
    visit question_answer_path(question, answer)

    expect(page).to have_field 'Passcode'
    expect(page).to_not have_content answer.answer
    expect(page).to_not have_content question.question
  end
end
