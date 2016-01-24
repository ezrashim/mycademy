class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course
    if @lesson.save
      flash[:notice] = " Woohoo! You've just added a lesson."
      redirect_to course_lesson_path(@course, @lesson)
    else
      flash.now[:error] = "Ooops...Something is not right."
      flash.now[:notice] = @course.errors.full_messages
      render 'new'
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @lesson = Lesson.new
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:id])
    if @lesson.destroy
      flash[:notice] = "Buddy, I hope you have a better lesson in mind, cuz you just deleted one heck of a lesson."
      redirect_to course_path(@course)
    else
      flash.now[:notice] = "Hey, you can't delete this stuff. Who are you trying to trick?"
      render :show
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(
      :title,
      :content,
      :order_no
    ).merge(course: Course.find(params[:course_id]))
  end
end
