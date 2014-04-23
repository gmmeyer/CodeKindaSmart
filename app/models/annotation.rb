class Annotation < ActiveRecord::Base

	validates :title, :annotation, :user_id, :document_id, 
		:start_location, :end_location, presence: true

	belongs_to :document
	belongs_to :user

end