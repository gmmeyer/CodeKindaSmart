class Annotation < ActiveRecord::Base

  validates :title, :body, :user_id, :document_id, :start_location, :end_location, presence: true

  belongs_to :document, inverse_of: :annotations, counter_cache: true
  belongs_to :user, inverse_of: :annotations

  has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

  after_commit :set_notification, on: [:create]

  def range
    return (self.start_location..self.end_location)
  end

  def set_notification
    notification = self.notifications.unread.event(:new_annotation_on_document).new
    notification.user = self.user
    notification.save
  end

end
