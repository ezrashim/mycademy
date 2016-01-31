require 'twilio-ruby'

class TextsController < ApplicationController
  before_action :authenticate_user!

  def create
    @text = text_params[:text]
    @enrollment_id = text_params[:enrollment_id].to_i
    @enrollment = Enrollment.find(@enrollment_id)
    @course = @enrollment.course
    @user = @enrollment.user
    @first_name = @user.first_name
    trigger_sms_alerts(@text)
    flash[:notice] = "Your text has been sent to #{@first_name}!"
    redirect_to enrollments_path(course_id: @course.id)
  end

  private

  def text_params
    params.require(:text).permit(
      :text,
      :enrollment_id
    )
  end

  def trigger_sms_alerts(text)
    @alert_message = text
    phone_number = "+1#{@user.area_code}#{@user.first_digits}#{@user.last_digits}"
    send_message(phone_number, @alert_message)
  end

  def send_message(phone_number, alert_message)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    message = @client.account.messages.create(
    :from => @twilio_number,
    :to => phone_number,
    :body => alert_message
    )
    puts message.to
  end
end
