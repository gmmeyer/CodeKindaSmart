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

  # The algo is described in the Annotation model,
  # this algo is merely a variation on that one.
  # Look there for further discussion of it.

  def score

    if self.annotations_count
      return self.annotations_count
    else
      return 0
    end

  end

  def ranking

    s = self.score

    # Natural logarithms are the only logaritms that matter.
    # Why do math in base 10 when you can use base e?
    order = Math.log([s, 1].max)

    if s > 0
      sign = 1
    else
      sign = 0
    end

    rank = (order * sign) + self.created_at.to_i / 45000

    rank
  end

  def self.update_ranking
    self.find_each do |user|
      user.rank = user.ranking
      user.save
    end
  end



  private

  def ensure_token
    self.token ||= self.class.generate_token
  end

end
