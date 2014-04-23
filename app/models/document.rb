class Document < ActiveRecord::Base
  validates :title, :document, :user_id, presence: true
  validates :title, uniqueness: true

  belongs_to :user
  has_many :annotations, dependent :destroy
end