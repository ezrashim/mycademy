require 'rails_helper'

feature 'create an answer for the question', %{
  As a learner, I should be able to create an answer for each question,
  So I can submit my progress for the lesson.
} do
  # ACCEPTANCE CRITERIA
  # * As a learner, I can submit an answer for the question
  # * So I can show my progress through the lessons.
  # * If I am a visitor, I cannot submit an answer.
  # * If I am a leader, I can create an answer sheet/ acceptance criteria.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'learner can create an answer' do
    sign_in_as learner
    visit new_question_answer_path(question)

    expect(page).to have_field 'Answer'

    fill_in 'Answer', with: "I just hope that our next president governs well, That's all."
    click_button 'Create Answer'

    expect(page).to have_content "Wow, wayda go #{learner.first_name}! You just submitted your answer!"
    expect(page).to have_content "I just hope that our next president governs well, That's all."
  end
end
