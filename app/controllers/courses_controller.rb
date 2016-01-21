class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      @enrollment = Enrollment.create(user: current_user, course: @course, role: 'leader')
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
