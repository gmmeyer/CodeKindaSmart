class Document < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  belongs_to :user
  has_many :annotations, dependent :delete
end