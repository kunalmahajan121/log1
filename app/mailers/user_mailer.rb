class UserMailer < ApplicationMailer
  def otp_email
    @user = params[:user]
    @qr_code = RQRCode::QRCode.new(@user.otp)
    attachments.inline['qrcode.png'] = @qr_code.as_png(size: 300).to_s

    mail(to: @user.email, subject: 'Your OTP QR Code')
  end
end
