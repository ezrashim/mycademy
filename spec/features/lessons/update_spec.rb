require 'rails_helper'

feature 'update a lesson', %{
  As a leader of the course,
  I should be able to update the details of a lesson,
  So learners can view the changed lesson details.
} do
  # ACCEPTANCE CRITERIA
  # * As a leader of the course, I can update lessons
  # * So that learners can see changed details.
  # * When lesson is updated, lesson no. stays unchanged.
  # * If I am a learner, I cannot see the update button.

  let!(:leader) { create :user }
  let!(:learner) { create :user }
  let!(:user) { create :user }
  let!(:course) { create :course_with_lessons }
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end
  let!(:learner_enrollment) do
    create :enrollment, role: 'learner', user: learner, course: course
  end

  scenario 'leader can update the lesson and lesson gets updated' do
    lesson = course.lessons.first
    sign_in_as(leader)
    visit course_lesson_path(course, lesson)
    find('#edit-lesson').click

    expect(page).to have_field('Title', with: lesson.title)
    expect(page).to have_field('Content', with: lesson.content)

    fill_in('Title', with: "I changed the lesson title")
    fill_in('Content', with: "Froala editor rocks!!!!!")
    click_button('Update Lesson')

    expect(page).to have_content("I changed the lesson title")
    expect(page).to have_content("Froala editor rocks!!!!!")
    expect(page).to have_content("#{leader.first_name},
    did you just make your lesson even better? Sweet!")

    find('#course-overview').click

    expect(page).to have_content(course.title)
    expect(page).to have_content(course.description)
    expect(page).to have_content("I changed the lesson title")
  end

  scenario 'leader cannot update the lesson if one of the field is blank' do
    lesson = course.lessons.first
    sign_in_as(leader)
    visit edit_course_lesson_path(course, lesson)

    expect(page).to have_field('Title', with: lesson.title)
    expect(page).to have_field('Content', with: lesson.content)

    fill_in('Content', with: "")
    click_button('Update Lesson')

    expect(page).to have_content("Sorry buddy, we couldn't change your lesson.
    Your input is invalid.")
    expect(page).to have_field("Title", with: lesson.title)
    expect(page).to have_field('Content')
  end

  scenario 'learner cannot update the lesson' do
    lesson = course.lessons.first
    sign_in_as learner
    visit edit_course_lesson_path(course, lesson)

    expect(page).to_not have_button('Update Lesson')
    expect(page).to_not have_field('Title')
    expect(page).to_not have_field('Content')
    expect(page).to have_content(lesson.title)
    expect(page).to have_content(lesson.content)

    visit course_lesson_path(course, lesson)

    expect(page).to_not have_css('#edit-lesson')
    expect(page).to have_content(lesson.title)
    expect(page).to have_content(lesson.content)
  end

  scenario 'visitor cannot update the course' do
    lesson = course.lessons.first
    visit edit_course_lesson_path(course, lesson)

    expect(page).to have_content('Sign In')

    visit course_lesson_path(course, lesson)

    expect(page).to have_content('Sign In')
  end
end
