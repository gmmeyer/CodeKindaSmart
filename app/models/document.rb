class Document < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  validates :title, uniqueness: true

  belongs_to :user
  has_many :annotations, dependent: :destroy

  def substring(starting, ending)
  	self.body[starting...ending]
  end

  def annotation_ranges

  	anns = self.annotations
  	annotation_hash = {}

  	anns.each do |ann|
  		annotation_hash[ann] = ann.range
  	end

  	annotation_hash
  end

  def segments

  	segments = {}

  end
end

# Document.first.annotation_ranges.select{ |k,v| Document.first.annotations.first.end_location < v.first }