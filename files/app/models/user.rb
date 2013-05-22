class User < ActiveRecord::Base

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = %r(\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z)i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  before_create :generate_authentication_token

  def self.authenticate(email, password)
    find_by(email: email).try(:authenticate, password)
  end

  private

    def generate_authentication_token
      begin
        self.authentication_token = SecureRandom.urlsafe_base64
      end while User.exists?(authentication_token: self.authentication_token)
    end
end