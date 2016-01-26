require 'rails_helper'

feature 'update a question', %{
  As a leader of the course,
  I should be able to upate the description of a question,
  So learners can view the changed question description.
} do
  # ACCEPTANCE CRITERIA
  # * As a leader of the course, I can update the Questions
  # * So that learners can see the changed details.
  # * If I am a learner, I cannot see the update button.

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

  scenario 'leader can update the question' do
    sign_in_as leader
    visit questions_path(lesson_id: lesson.id)
    click_link('Update Question')

    expect(page).to have_field 'Question', with: question.description
  end
end
