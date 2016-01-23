require 'rails_helper'

feature 'learners can view lesson contents', %{
  As a learner,
  I should be able to view the contents of the lesson,
  So I can learn from the course.
  } do
  # ACCEPTANCE CRITERIA
  # * As a learner, I can view the content of the lesson,
  # * and view a button to 'Quiz'.
  # * As a leader, I can view the content of the lesson,
  # * and view the button to 'Quiz'.
  # * As an authenticated user, I cannot view the content to the lesson.
  # * As a visitor, I cannot view the content of the lesson.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'learner can view the content of the lesson' do
    lesson = course.lessons.first

    sign_in_as(learner)
    visit course_path(course)
    click_link lesson.title

    expect(page).to have_content lesson.title
    expect(page).to have_content lesson.content
    expect(page).to_not have_content 'Join Course'
    expect(page).to_not have_content 'Join Mycademy'
  end
end
