require 'rails_helper'

feature 'leaders can view the list of students enrolled in his or her course', %{
  As a leader,
  I should be able to view the list of students enrolled in the course,
  So he can keep the students accountable.
  } do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can view the list of student enrollment in the course.
  # * As a leader, I have the option delete student enrollment.
  # * As a learner, I can view the student enrollment in the course.
  # * As a learner, I cannot delete student enrollment.
  # * As a visitor, I cannot view the student enrollment.

  let!(:leader) { create :user }
  let!(:learner_1) { create :user }
  let!(:learner_2) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_1_enrollment) { create :enrollment, role: 'learner', user: learner_1, course: course }
  let!(:learner_2_enrollment) { create :enrollment, role: 'learner', user: learner_2, course: course }

  scenario 'leader can view the student enrollment in the course' do
    sign_in_as leader
    visit course_path(course)
    find('#enrollment').click

    expect(page).to have_content learner_1.first_name
    expect(page).to have_content learner_1.last_name
    expect(page).to have_content learner_2.first_name
    expect(page).to have_content learner_2.last_name
  end

  scenario 'leader can remove the student enrollment in the course' do
    sign_in_as leader
    visit course_path(course)
    find('#enrollment').click
    first(:css, '.delete-enrollment').click

    expect(page).to have_content "I'm sorry to hear that you removed
      #{learner_1.first_name} from your class."
    expect(page).to_not have_content learner_1.last_name
    expect(page).to have_content learner_2.first_name
    expect(page).to have_content learner_2.last_name
  end

  scenario 'learner can view the student enrollment in the course' do
    sign_in_as learner_1
    visit course_path(course)
    find('#enrollment').click

    expect(page).to have_content "Led by #{leader.first_name} #{leader.last_name}"
    expect(page).to have_content learner_2.first_name
    expect(page).to have_content learner_2.last_name
    expect(page).to_not have_content learner_1.last_name
  end

  scenario 'learner cannot remove the student enrollment in the course' do
    sign_in_as learner_1
    visit course_path(course)
    find('#enrollment').click

    expect(page).to_not have_link 'Remove'
    expect(page).to_not have_link "#{learner_2.first_name} #{learner_2.last_name}"
    expect(page).to have_content "#{learner_2.first_name} #{learner_2.last_name}"
  end

  scenario 'authenticated user cannot view the student enrollment in the course' do
    sign_in_as user
    visit course_path(course)

    expect(page).to_not have_css '#enrollment'
    expect(page).to have_link "Join Course"
  end

  scenario 'visitor cannot view the student enrollment in the course' do
    visit course_path(course)

    expect(page).to_not have_css '#enrollment'
    expect(page).to have_link "Join Mycademy"
  end
end
