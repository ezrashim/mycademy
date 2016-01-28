require 'rails_helper'

feature 'destroy an answer', %{
  As a learner,
  I should be able to destroy a question,
} do
  # ACCEPTANCE CRITERIA
  # * As a learner of the course, I can delete my answer
  # * So that the leader cannot view.
  # * If I am a visitor, I cannot delete a question.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }
  let!(:answer) { create :answer, enrollment: learner_enrollment, question: question }
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end
  let!(:learner_enrollment) do
    create :enrollment, role: 'learner', user: learner, course: course
  end

  scenario 'learner can delete the answer' do
    sign_in_as learner
    visit question_answer_path(question, answer)
    find('#delete-answer').click

    expect(page).to have_content question.question
    expect(page).to_not have_content answer.answer
  end

  scenario 'leader cannot delete the answer' do
    sign_in_as leader
    visit question_answer_path(question, answer)
    expect(page).to_not have_css('#delete-answer')

    expect(page).to have_content question.question
    expect(page).to have_content answer.answer
  end
end
