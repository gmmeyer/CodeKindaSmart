class Annotation < ActiveRecord::Base

  validates :title, :body, :user_id, :document_id,
    :start_location, :end_location, presence: true

  belongs_to :document
  belongs_to :user

  def range
  	return (self.start_location..self.end_location)
  end

end
