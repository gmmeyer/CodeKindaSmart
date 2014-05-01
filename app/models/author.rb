class Author < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true

  has_many :documents, inverse_of: :author

  include PgSearch
  multisearchable against: [:name, :location]

  def builder
  	Jbuilder.encode do |json|
  		json.(self, name)
  	end
  end

end