class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @course = Course.find(params[:course_id])
    @lessons = @course.lessons
    @enrollment = Enrollment.find(params[:id])
    @learner = @enrollment.user
  end

  def new
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new
  end

  def create
    @passcode = params[:passcode]
    @course = Course.find(params[:course_id])
    if @course.passcode == @passcode
      @enrollment = Enrollment.create(user: current_user, course: @course)
      flash[:notice] = "Welcome to #{@course.title}! You are now enrolled!"
      redirect_to course_path(@course)
    else
      flash.now[:notice] = "Nah...that's not the right passcode. Try again."
      render 'new'
    end
  end

  def index
    @course = Course.find(params[:course_id])
    @enrollments = Enrollment.where(course: @course)
    @leader = @enrollments.find_by(role: 'leader').user
    @lessons = @course.lessons
    @text = Text.new
    q_count = 0
    @lessons.each do |lesson|
      q_count += lesson.questions.size
    end
    @q_count = q_count
  end

  def destroy
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.find(params[:id])
    @answers = @enrollment.answers
    @answers.destroy_all
    if @enrollment.destroy
      flash[:notice] = "I'm sorry to hear that you removed #{@enrollment.user.first_name} from your class."
      redirect_to enrollments_path(course_id: @course.id)
    else
      flash[:notice] = "You couldn't remove #{@enrollment.user.first_name} from your class."
      render 'index'
    end
  end
end
