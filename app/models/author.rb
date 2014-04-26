class Author < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true

	has_many :documents

end