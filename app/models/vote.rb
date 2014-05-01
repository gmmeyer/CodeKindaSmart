class Vote < ActiveRecord::Base
  validates :annotation_id, :type, :user_id, presence: true
  validates :annotation_id, uniqueness: {
    scope: :user_id,
    message: "You can only vote once!"
  }
  after_commit :set_notification#, on: [:create, :upvote, :downvote]
  validate :cannot_vote_on_own_post

  belongs_to :user
  belongs_to :annotation

  has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

  private
  def set_notification
    # this will always be overridden. I should probably replace all of this with an alert and remove the class from the notifications.
    # I should ask about this tomorrow.
    raise "Only use upvotes and downvote. This isn't mean to be used."
    # notification = self.notifications.unread.event(:new_vote_on_annotation).new
    # notification.user = self.user
    # notification.save
  end

  def cannot_vote_on_own_post
    if self.annotation.user_id == self.user_id
      errors[:base] << "You can't vote on your own annotation, silly."
    end
  end
end