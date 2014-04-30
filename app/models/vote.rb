class Vote < ActiveRecord::Base
  validates :annotation_id, :type, :user_id, presence: true
  validates :annotation_id, uniqueness: {
    scope: :user_id,
    message: "You can only vote once!"
  }
  validate :cannot_vote_on_own_post

  belongs_to :user
  belongs_to :annotation
  after_commit :set_notification, on: [:create]


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


class UpVote < Vote # I should break this out into its own file.

  belongs_to :user, counter_cache: true
  belongs_to :annotation, counter_cache: true

  def vote_type
    @type = "upvote"
    @type
  end

  def self.find_or_create_upvote #this is ripe for metaprogramming
    if params[:existing_vote]
      return current_user.upvotes.new(vote_params)
    else
      vote = current_user.votes.find_by(user_id: params[:user_id])
      vote.vote_type = params[:vote_type]
      return vote
    end
  end

  private
  def set_notification
    notification = self.notifications.unread.event(:new_upvote_on_annotation).new
    notification.user = self.user
    notification.save
  end
end

class DownVote < Vote # I should break this out, too.

  belongs_to :user, counter_cache: true
  belongs_to :annotation, counter_cache: true

  def vote_type
    @type = "downvote"
    @type
  end

  def self.find_or_create_downvote
    if params[:existing_vote]
      return current_user.downvotes.new(vote_params)
    else
      vote = current_user.votes.find_by(user_id: params[:user_id])
      vote.vote_type = params[:vote_type]
      return vote
    end
  end

  private
  def set_notification
    notification = self.notifications.unread.event(:new_downvote_on_annotation).new
    notification.user = self.user
    notification.save
  end
end
