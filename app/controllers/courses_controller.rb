class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      flash[:notice] = "You are now ready to lead a course!"
      redirect_to course_path(@course)
    else
      flash[:notice] = @course.errors.full_messages
      render 'new'
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(
    :title,
    :description
    )
  end
end
