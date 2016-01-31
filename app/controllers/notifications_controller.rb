class NotificationsController < ApplicationController

  def trigger_sms_alerts
    @alert_message = "[This is a test] Hey Ezra, This is Ezra. :)"
    @admin_list = YAML.load_file('config/administrators.yml')

    begin
      @admin_list.each do |admin|
        phone_number = admin['phone_number']
        send_message(phone_number, @alert_message)
      end
    end
  end

  private

  def send_message(phone_number, alert_message)
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twillio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

    message = @client.account.messages.create(
    :from => @twilio_number, 
    :to => phone_number,
    :body => alert_message
    )
    puts message.to
  end
end
