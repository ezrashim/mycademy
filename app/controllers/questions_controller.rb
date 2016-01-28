class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @course = Course.find(lesson.course.id)
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @questions = Question.where(lesson: lesson)
  end

  def create
    @lesson = Lesson.find(params[:question][:lesson_id])
    @course = Course.find(@lesson.course.id)
    @question = Question.new(question_params)
    @questions = Question.where(lesson: @lesson)
    if @question.save
      flash[:notice] = "You just created a new question!"
      redirect_to course_lesson_path(@course, @lesson)
    else
      flash[:notice] = "Question couldn't be posted."
      render 'lessons/show'
    end
  end

  def new
    lesson
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @lesson = @question.lesson
    @course = Course.find(@lesson.course.id)
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @answer = Answer.new
  end

  def edit
    lesson
    @question = Question.find(params[:id])
  end

  def destroy
    lesson
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:notice] = "We got you. Your question will no longer be asked."
      redirect_to questions_path(lesson_id: @lesson.id)
    else
      flash.now[:notice] = "Nice try. You won't get rid of this awesome question."
      render :index
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "Ask different! :p"
      redirect_to question_path(@question)
    else
      flash.now[:notice] = "I say just keep it as is...or you can try to change again."
      render :show
    end
  end

  private

  def lesson
    @lesson ||= Lesson.find(params[:lesson_id])
  end

  def question_params
    params.require(:question).permit(
      :question,
      :lesson_id
    )
  end
end
