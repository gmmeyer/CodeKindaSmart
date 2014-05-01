class UpVote < Vote

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
    notification.user = self.annotation.user
    notification.save
  end
end