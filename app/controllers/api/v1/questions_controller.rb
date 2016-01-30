class Api::V1::QuestionsController < Api::V1::BaseController
  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:notice] = "We got you. Your question will no longer be asked."
      render json: { result: 'success' }
    else
      flash.now[:notice] = "Nice try. You won't get rid of this awesome question."
    end
  end
end
