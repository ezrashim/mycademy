require 'rails_helper'

feature 'learners can view the progress of the enrolled class', %{
  As a learner,
  I should be able to view the progress I am making in the course
  such as list of lessons, questions answered, and questions unanswered.
} do
  # * ACCEPTANCE CRITERIA
  # * As a learner, I can view the list of lessons of the course.
  # * As a learner, I can view the checks of questions answered.
  # * As a learner, I can view the checks of questions unanswered.
  # * leader can have the same access to the students' progress page.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
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

  scenario 'learner can view the list of lessons of the course' do
    sign_in_as(learner)
    visit enrollment_path(learner_enrollment, course_id: course.id)

    expect(page).to have_content course.title
    expect(page).to have_content course.description
    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.lesson_no
    expect(page).to have_css '#complete'
  end
end
