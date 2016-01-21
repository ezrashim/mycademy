require 'rails_helper'

feature 'authenticated users can view course details', %{
  As an authenticated user,
  I should be able to view the details of the course,
  So I can choose to join the course
  } do
  # ACCEPTANCE CRITERIA
  # * As an authenticated user, I can view the details of the course,
  # * and view a button to 'Join Course'
  # * As an unauthenticated user, I can view the details of teh course,
  # * but cannot view a button to 'Join Course'
  # * Instead I see a button to 'Join Mycademy'
    let!(:user) { create(:user) }
    let!(:course) { create(:course) }
  scenario 'authenticated users can join courses on show page' do
    # user = create(:user)
    # course = create(:course_with_lessons, 3)
    sign_in_as(user)

    click_link(course.title)

    expect(page).to have_content(course.title)
    expect(page).to have_content(course.description)
    expect(page).to have_content('Join Course')
    expect(page).to_not have_content('Join Mycademy')
    # click_link('Join Course')
    #
    # course.lessons.each do |lesson|
    #   expect(page).to have_content(lesson.title)
    #   expect(page).to have_content(lesson.body)
    # end
  end

  scenario 'visitors cannot join course on show page' do
    visit root_path
    click_link(course.title)

    expect(page).to have_content(course.title)
    expect(page).to have_content(course.description)
    expect(page).to have_content('Join Mycademy')
    expect(page).to_not have_content('Join Course')

  end
end
