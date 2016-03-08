class Api::V1::CoursesController < Api::V1::BaseController
  def index
    @courses = Course.all
    render json: { courses: @courses }
  end
end
