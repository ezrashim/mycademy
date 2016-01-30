require 'rails_helper'

feature 'update a course', %{
  As a leader of the course,
  I should be able to update the details of a course,
  So learners can view the changed course details.
} do
  # ACEPTANCE CRITERIA
  # * As a leader of the course, I can update a course
  # * So that others can see changed details.
  # * If I am a learner, I cannot see the update button.
  # * If I am a visior, I cannot see the update button.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:course) { create :course }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'leader can update the course and course gets updated' do
    sign_in_as(leader)
    visit course_path(course)
    find('#edit-course').click

    expect(page).to have_field('Title', with: course.title.to_s)
    expect(page).to have_field('Description', with: course.description.to_s)

    fill_in('Title', with: "Math")
    click_button('Update Course')

    expect(page).to have_content("Congratz! You just improved your course!")
    expect(page).to have_content("Math")
    expect(page).to_not have_content(course.title.to_s)
    expect(page).to have_content(course.description.to_s)
  end

  scenario 'leader cannot update the course if one of the field is blank' do
    sign_in_as(leader)
    visit course_path(course)
    find('#edit-course').click

    expect(page).to have_field('Title', with: course.title.to_s)
    expect(page).to have_field('Description', with: course.description.to_s)

    fill_in('Description', with: "")
    click_button('Update Course')

    expect(page).to have_content("Sorry buddy, we couldn't change your course. Your input is invalid.")
    expect(page).to have_field("Title")
    expect(page).to have_field("Description")
  end

  scenario 'learner cannot update the course' do
    sign_in_as(learner)
    visit course_path(course)

    expect(page).to have_content('Progress')
    expect(page).to_not have_content('Update Course')
  end

  scenario 'visitor cannot update the course' do
    visit course_path(course)

    expect(page).to have_content('Join Mycademy')
    expect(page).to_not have_content('Update Course')
    expect(page).to_not have_content('Progress')
  end
end
