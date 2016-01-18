class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_paramaters, if: :devise_controller?

  protected

  def configure_permitted_paramaters
    devise_parameter_sanitizer.for(:sign_up) << [
      :first_name,
      :last_name,
      :role
    ]
  end

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
