class User < ActiveRecord::Base
  has_secure_password

  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :username, :email, uniqueness: true
  validates :username, :token, :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }

  before_validation :ensure_token

  has_many :notifications, inverse_of: :user, dependent: :destroy
  has_many :documents, inverse_of: :user, dependent: :destroy
  has_many :annotations, inverse_of: :user, dependent: :destroy
  has_many :notifications, inverse_of: :user, dependent: :destroy

  has_many :upvotes, class_name: "UpVote"
  has_many :downvotes, class_name: "DownVote"

  include PgSearch
  pg_search_scope :search_on_name, against: [:username, :email]
  multisearchable againt: [:username, :email]

  def self.generate_token
    SecureRandom.urlsafe_base64(32)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    return @user.authenticate(password) unless @user.nil?
    return @user
  end

  def reset_token!
    self.token = self.class.generate_token
    self.save!
  end

  def is_password?(password)
    self.authenticate(password)
  end

  # Ranking

  def self.update_score



  end

  def self.update_ranking

  end



  private

  def ensure_token
    self.token ||= self.class.generate_token
  end

end
