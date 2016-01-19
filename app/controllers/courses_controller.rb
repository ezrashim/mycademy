class CoursesController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  def index
    @courses = Course.all
  end
end
