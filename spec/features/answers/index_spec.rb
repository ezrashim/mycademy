require 'rails_helper'

feature 'view answers', %{
  As a leader,
  I should be able to view all the answers of each question,
  So I can grade the answers for the question.
} do
  # ACCEPTANCE CRITERIA
  # * As a leader, I can view all the answers
  # * So I can grade them.
  # * If I am a learner, I cannot view all the answers.
  # * If I am a visitor, I cannot view all the answers.

  let!(:user) { create :user }
  let!(:leader) { create :user }
  let!(:leader_enrollment) do
    create :enrollment, role: 'leader', user: leader, course: course
  end

  let!(:course) { create :course }
  let!(:lesson) { create :lesson, course: course }
  let!(:question) { create :question, lesson: lesson }

  let!(:learners) { create_list(:user, 10) }

  scenario 'leader can view all the answers to the question' do
    learners.each do |learner|
      enrollment = create :enrollment, user: learner, course: course
      create :answer, enrollment: enrollment, question: question
    end

    sign_in_as leader
    visit question_answers_path(question)

    expect(page).to have_content(question.question)
    question.answers.each do |answer|
      expect(page).to have_content(answer.answer)
      expect(page).to have_content("Submitted by #{answer.enrollment.user.first_name} #{answer.enrollment.user.last_name}")
    end
  end

  scenario 'learners cannot view the questions except theirs' do
    learners.each do |learner|
      enrollment = create :enrollment, user: learner, course: course
      create :answer, enrollment: enrollment, question: question
    end

    learner = learners.first
    sign_in_as learner
    visit question_answers_path(question)

    expect(page).to have_content(question.question)
    expect(page).to have_content("I think you are a bit lost, buddy. You need to be the leader to view this page. Time to go back to where you belong.")
    expect(page).to have_css('#course-overview')
  end

  scenario 'visitor cannot view any answers' do
    sign_in_as user
    visit question_answers_path(question)

    expect(page).to have_content("I think you are a bit lost, buddy. You need to be the leader to view this page. Time to go back to where you belong.")
    expect(page).to have_css('#course-overview')
  end
end
