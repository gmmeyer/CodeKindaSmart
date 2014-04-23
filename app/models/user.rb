class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :username, :email, uniqueness: true
  validates :username, :session_token, presence: true
  before_validation :ensure_session_token

  has_many :documents, dependent :destroy
  has_many :annotations, dependent :destroy

  def self.generate_session_token
    SecureRandom.urlsafe_base64(32)
  end

  def self.find_by_credentials(username, password)
    @user = user.find_by(username: username)

    return @user.authenticate(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def is_password?(password)
    self.authenticate(password)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
