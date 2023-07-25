class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  
  before_create :generate_otp

  def generate_otp
    self.otp = SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
    self.otp_expiration = Time.now + 5.minutes # Set an expiration time for the OTP (e.g., 5 minutes)
  end
end
