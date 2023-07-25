class SendOtpJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    user.generate_otp
    UserMailer.with(user: user).otp_email.deliver_now
  end
end