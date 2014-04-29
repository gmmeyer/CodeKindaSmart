class Vote < ActiveRecord::Base
  validates :annotation_id, :user_id, presence: true
  validates :annotation_id, uniqueness:{
    scope: :user_id
    message: ["You can't vote on your own annotation, silly."]
  }
  # before_validation :record_vote_type
  before_validation :ensure_one_vote

  belongs_to :user
  belongs_to :annotation


  private
  def ensure_one_vote
    if self.vote_type = 1
      self.upvote = 1
      self.downvote = nil
    elsif self.vote_type = -1
      self.upvote = nil
      self.downvote = 1
    end
  end

  # def record_vote_type
  # 	if self.vote_type = 1
  # 		self.upvote = 1
  # 		self.downvote = nil
  # 	elsif self.vote_type = -1
  # 		self.downvote = nil
  # 		self.upvote = 1
  # 	end
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
