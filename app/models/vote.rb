class Vote < ActiveRecord::Base
  validates :annotation_id, :user_id
  validates :annotation_id, uniqueness:{
  	scope: :user_id
  	message: ["You can't vote on your own annotation, silly."]
  }




end
