require 'bcrypt'
class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :username, :email, uniqueness: true
  validates :username, :token, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  has_many :notifications, inverse_of: :user, dependent: :destroy


  has_many :documents, inverse_of: :user, dependent: :destroy
  has_many :annotations, inverse_of: :user, dependent: :destroy
  has_many :notifications, inverse_of: :user, dependent: :destroy

  def self.generate_token
    SecureRandom.urlsafe_base64(32)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return @user.authenticate(password)
  end

  def reset_token!
    self.token = self.class.generate_token
    self.save!
  end

  def is_password?(password)
    self.authenticate(password)
  end

  private

  def ensure_token
    self.token ||= self.class.generate_token
  end

end
