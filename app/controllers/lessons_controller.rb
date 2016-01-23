class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
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
