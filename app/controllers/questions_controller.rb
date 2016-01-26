class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @lesson = Lesson.find(params[:question][:lesson_id])
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "You just created a new question!"
      redirect_to question_path(@question)
    else
      flash[:notice] = "Question couldn't be posted."
      render 'new'
    end
  end

  def new
    @lesson = Lesson.find(params[:lesson_id])
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(
      :description,
      :lesson_id
    )
  end
end
