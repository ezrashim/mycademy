class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

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
end
