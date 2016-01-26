require 'rails_helper'

feature 'destroy a question', %{
  As a leader,
  I should be able to destroy a question,
  So nobody can view the question
} do
  # ACCPTANCE CRITERIA
  # * As a leader of the course, I can delete a question
  # * So that others cannot view.
  # * If I am a learner, I cannot delete a question.

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

  scenario 'leader can delete the question' do
    sign_in_as leader
    visit question_path(question)
    click_link('Remove Question')

    expect(page).to have_content "We got you. Your question will no longer be asked."
    expect(page).to_not have_content question.question
  end

  scenario 'learner connot delete the course' do
    sign_in_as learner
    visit question_path(question)

    expect(page).to_not have_link('Remove Question')
    expect(page).to have_content question.question
  end
end
