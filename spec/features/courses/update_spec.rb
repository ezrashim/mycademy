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
  let!(:visitor) { create :user }
  let!(:course) { create :course }
  let!(:leader_enrollment) { create :enrollment, role: 'leader', user: leader, course: course }
  let!(:learner_enrollment) { create :enrollment, role: 'learner', user: learner, course: course }

  scenario 'leader can update the course and course gets updated' do
    sign_in_as(leader)
    click_link(course.title)
    click_link('Update Course')

    expect(page).to have_field('Title', with: course.title.to_s )
    expect(page).to have_field('Description', with: course.description.to_s )

    fill_in('Title', with: "Math")
    click_button('Update Course')

    expect(page).to have_content("Congratz! You just improved your course!")
    expect(page).to have_content("Math")
    expect(page).to_not have_content(course.title.to_s)
    expect(page).to have_content(course.description.to_s)
  end

  scenario 'learner cannot update the course' do
    sign_in_as(learner)
    click_link(course.title)

    expect(page).to have_content('View My Progress')
    expect(page).to_not have_content('Update Course')
  end

  scenario 'visitor cannot update the course' do
    visit root_path
    click_link(course.title)

    expect(page).to have_content('Join Mycademy')
    expect(page).to_not have_content('Update Course')
    expect(page).to_not have_content('View My Progress')
  end
end
