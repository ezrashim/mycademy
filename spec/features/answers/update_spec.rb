require 'rails_helper'

feature 'update an answer', %{
  As a learner of the course,
  I should be able to update the answer that I submitted,
  So a leader can view the changed answer.
} do
  # ACCEPTANCE CRITERIA
  # * As a learner of the course, I can update the answers I submitted
  # * So that the leader can see the changed answer.
  # * If I am a leader, I cannot change the answer.

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

  scenario 'learner can update the answer' do
    sign_in_as learner
    visit question_answer_path(question, answer)
    click_link 'Update Answer'

    expect(page).to have_field 'Answer'

    fill_in 'Answer', with: "this is an update!!!!"

    click_button 'Update Answer'

    expect(page).to have_content "Woohoo!! You've updated your answer.This one definitely sounds nicer."
    expect(page).to have_content "this is an update!!!!"
  end
end
