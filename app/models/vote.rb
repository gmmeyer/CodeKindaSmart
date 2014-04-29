class Vote < ActiveRecord::Base
  validates :annotation_id, :user_id, presence: true
  validates :annotation_id, uniqueness:{
    scope: :user_id,
    message: "You can only vote once!"
  }
  validates :cannot_vote_on_own_post

  validates :annotation_id
  # before_validation :record_vote_type
  before_validation :ensure_one_vote

  belongs_to :user
  belongs_to :annotation





  private
  def ensure_one_vote
    if self.type = "upvote"
      self.upvote = 1
      self.downvote = nil
    elsif self.type = "downvote"
      self.upvote = nil
      self.downvote = 1
    end
  end

  def cannot_vote_on_own_post
    if self.annotation.user_id == current_user.id 
      errors.add("You can't vote on your own annotation, silly.")
    end
  end

  # def record_vote_type
  #   if self.vote_type = 1
  #     self.upvote = 1
  #     self.downvote = nil
  #   elsif self.vote_type = -1
  #     self.downvote = nil
  #     self.upvote = 1
  #   end
  # end
end


class UpVote < Vote

  belongs_to :user, counter_cache: true
  belongs_to :annotation, counter_cache: true

  def vote_type
    @type = "upvote"
    @type
  end
end

class DownVote < Vote

  belongs_to :user, counter_cache: true
  belongs_to :annotation, counter_cache: true

  def vote_type
    @type = "downvote"
    @type
  end
end
