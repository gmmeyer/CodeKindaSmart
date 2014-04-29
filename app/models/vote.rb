class Vote < ActiveRecord::Base
  validates :annotation_id, :user_id, presence: true
  validates :annotation_id, uniqueness:{
    scope: :user_id
    message: ["You can't vote on your own annotation, silly."]
  }
  before_validation :record_vote_type

  belongs_to :user
  belongs_to :annotation


  private
  def record_vote_type
  	if self.vote_type = 1
  		self.upvote = 1
  		self.downvote = nil
  	elsif self.vote_type = -1
  		self.downvote = nil
  		self.upvote = 1
  	end
  end
end
