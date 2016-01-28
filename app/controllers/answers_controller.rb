class AnswersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @question = Question.find(params[:question_id])
    @lesson = @question.lesson
    @course = Course.find(@lesson.course.id)
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @answer = Answer.new(answer_params)
    if @answer.save
      flash[:notice] = "Wow, wayda go #{current_user.first_name}! You just submitted your answer!"
      redirect_to question_answer_path(@question, @answer)
    else
      flash[:notice] = "Something went wrong. We couldn't sumbit your answer. Did you write anything?"
      render 'questions/new'
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @question = Question.find(params[:question_id])
    @lesson = @question.lesson
    @course = Course.find(@lesson.course.id)
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
  end

  def edit
    @question = Question.find(params[:question_id])
    @lesson = @question.lesson
    @course = Course.find(@lesson.course.id)
    @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @answer = Answer.find(params[:id])
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      flash[:notice] = "Woohoo!! You've updated your answer.This one definitely sounds nicer."
      redirect_to question_answer_path(@question, @answer)
    else
      flash.now[:notice] = "Your answer don't need to change. But if you insist, try again."
      render :show
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @lesson = @question.lesson
    # @course = Course.find(@lesson.course.id)
    # @enrollment = Enrollment.find_by(user: current_user, course: @course)
    @answer = Answer.find(params[:id])
    if @answer.destroy
      flash[:notice] = "Your answer has been removed. You must have something extraordinary waiting to be written!"
      redirect_to question_path(@question, lesson_id: @lesson.id)
    else
      flash.now[:notice] = "Your answer will stay as it is. Why don't you give update a try?"
      render :show
    end
  end

  private

  def answer_params
    params.require(:answer).permit(
      :answer,
      :question_id,
      :enrollment_id
    )
  end

end
