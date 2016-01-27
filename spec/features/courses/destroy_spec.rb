require 'rails_helper'

feature 'destroy a course', %{
  As a leader,
  I should be able to destroy a course,
  So nobody can view or join the course
} do
  # ACCEPTANCE CRITERIA
  # * As a leader of the course, I can delete a course
  # * So that others cannot view or join.
  # * If I am not a leader, I cannot delete a course

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:course) { create :course }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario "leader can delete the course" do
    sign_in_as(leader)
    click_link(course.title)
    find('#delete-course').click

    expect(page).to have_content("Hey buddy, you just deleted your own course!")
    expect(page).to_not have_content(course.title)
  end

  scenario "learner cannot delete the course" do
    sign_in_as(learner)
    click_link(course.title)

    expect(page).to have_content(course.title)
    expect(page).to have_content(course.description)
    expect(page).to_not have_content('#delete-course')
  end
end
