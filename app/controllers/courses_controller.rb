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
    course
    @lessons = Lesson.where(course_id: course)
    @enrollment = Enrollment.find_by(user: current_user, course: course)

    if user_signed_in? && @enrollment.nil?
      flash.now[:notice] = "Yo, sorry. You gotta join the team first."
      render 'show'
    end
  end

  def edit
    course
  end

  def update
    if course.update(course_params)
      flash[:notice] = "Congratz! You just improved your course!"
      redirect_to @course
    else
      flash.now[:notice] = "Sorry buddy, we couldn't change your course. Your input is invalid."
      render 'edit'
    end
  end

  def destroy
    course
    if @course.destroy
      flash[:notice] = "Hey buddy, you just deleted your own course!"
      redirect_to root_path
    else
      flash[:notice] = "Sorry, #{current_user.first_name}. We couldn't delete #{course.title}."
      render :show
    end
  end

  private

  def enrollment
    @enrollment ||= Enrollment.find_by(user: current_user, course: course)
  end

  def course
    @course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(
    :title,
    :description
    )
  end
end
