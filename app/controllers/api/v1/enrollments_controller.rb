class Api::V1::EnrollmentsController < Api::V1::BaseController
  def destroy
    @enrollment = Enrollment.find(params[:id])
    @course = @enrollment.course
    @answers = @enrollment.answers
    @answers.destroy_all
    if @enrollment.destroy
      flash[:notice] = "I'm sorry to hear that you removed #{@enrollment.user.first_name} from your class."
      render json: { result: 'success' }
    else
      flash[:notice] = "You couldn't remove #{@enrollment.user.first_name} from your class."
    end
  end
end
