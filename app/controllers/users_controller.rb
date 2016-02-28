class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @leading = @user.enrollments.where(role: "leader")
    @learning = @user.enrollments.where(role: "learner")
  end
end
