class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lesson = Lesson.find(params[:id])
    @course = @lesson.course
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @questions =  Question.where(lesson: @lesson)
    @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
    if @enrollment.nil?
      redirect_to new_enrollment_path(course_id: @course.id)
    end
  end

  def create
    @course = Course.find(params[:course_id])
    @lesson = Lesson.new(lesson_params)
    @lesson.course = @course
    @lesson_no = @course.lessons.length + 1
    if @lesson.save
      flash[:notice] = " Woohoo! You've just added a lesson."
      redirect_to course_lesson_path(@course, @lesson)
    else
      flash.now[:error] = "Ooops...Something is not right."
      flash.now[:notice] = @course.errors.full_messages
      render 'edit'
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @lesson = Lesson.new
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @lesson_no = @course.lessons.length + 1
  end

  def destroy
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:id])
    @questions = Question.where(lesson: @lesson)
    if @questions.present?
      @questions.each do |question|
        question.answers.destroy_all
      end
      @questions.destroy_all
    end
    if @lesson.destroy
      flash[:notice] = "Buddy, I hope you have a better lesson in mind,
      cuz you just deleted one heck of a lesson."
      redirect_to course_path(@course)
    else
      flash.now[:notice] = "Hey, you can't delete this stuff.
      Who are you trying to trick?"
      render :show
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:id])
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @lesson_no = @lesson.lesson_no
    if !@enrollment.nil? && @enrollment.leader?
      render 'edit'
    else
      redirect_to course_lesson_path(@course, @lesson)
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @lesson = Lesson.find(params[:id])
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    if params[:direction].present? && params[:direction] == "down"
      @next_lesson = Lesson.find_by(course: @course, lesson_no: @lesson.lesson_no + 1)

      if @next_lesson.present?
        @lesson.increment!(:lesson_no)
        @next_lesson.increment!(:lesson_no, -1)
        flash[:notice] = "#{current_user.first_name},
        you want that lesson to be later, eh? Good thinking."
        redirect_to course_path(@course)
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render 'courses/show'
      end
    elsif params[:direction].present? && params[:direction] == "up"
      @previous_lesson = Lesson.find_by(course: @course, lesson_no: @lesson.lesson_no - 1)
      if @previous_lesson.present?
        if @previous_lesson.increment!(:lesson_no)
          @lesson.increment!(:lesson_no, -1)
          flash[:notice] = "#{current_user.first_name},
          you want that lesson to be sooner, eh? Wise choice."
          redirect_to course_path(@course)
        end
      else
        @lessons = Lesson.where(course_id: @course).sort_by { |a| a.lesson_no }
        render 'courses/show'
      end
    end

    unless params[:lesson].nil? || params[:lesson].empty?
      if @lesson.update(lesson_params)
        flash[:notice] = "#{current_user.first_name},
        did you just make your lesson even better? Sweet!"
        redirect_to course_lesson_path(@course, @lesson)
      else
        flash.now[:notice] = "Sorry buddy, we couldn't change your lesson.
        Your input is invalid."
        render 'edit'
      end
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(
      :title,
      :content,
      :lesson_no,
      :course_id
    ).merge(course: Course.find(params[:course_id]))
  end
end
