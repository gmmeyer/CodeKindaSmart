class Annotation < ActiveRecord::Base

  validates :title, :body, :user_id, :document_id, :start_location, :end_location, presence: true

  belongs_to :document, inverse_of: :annotations, counter_cache: true
  belongs_to :user, inverse_of: :annotations

  has_many :upvotes, class_name: "UpVote"
  has_many :downvotes, class_name: "DownVote"

  has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

  after_commit :set_notification, on: [:create]

  def load_user_vote(current_user)
    if current_user
      downvote = downvotes.where(user_id: current_user.id) 
      upvote = upvotes.where(user_id: current_user.id)
      @my_vote = "downvote" if !downvote.empty?
      @my_vote = "upvote" if !upvote.empty?
    end

    @my_vote = nil
  end

  def my_vote
    @my_vote
  end

  def range
    return (self.start_location..self.end_location)
  end

  private
  def set_notification
    notification = self.notifications.unread.event(:new_annotation_on_document).new
    notification.user = self.user
    notification.save
  end
end
