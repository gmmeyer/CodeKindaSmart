class Notification < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  EVENTS = {
    1 => :new_annotation_on_document
  }

  EVENT_IDS = EVENTS.invert

  belongs_to :user, inverse_of: :notifications, counter_cache: true
  belongs_to :notifiable, inverse_of: :notifications, polymorphic: true, counter_cache: true

  validates :event_id, inclusion: { in: EVENTS.keys}
  validates :is_read, inclusion: { in: [true, false]}
  validates :notifiable, :user, presence: true

  scope :read, -> { where(is_read: true) }
  scope :unread, -> { where(is_read: false) }
  scope :event, ->(event_name) { where(event_id: EVENT_IDS[event_name]) }

  def url
    case self.event_name
    when :new_annotation_on_document
      annotation = self.notifiable
      document_url(annotation.document_id)
    end
  end

  def text
    case self.event_name
    when :new_annotation_on_document
      annotation = self.notifiable
      annotation_user = annotation.user
      document = annotation.document

      "#{annotation_user.username} annotated your document #{document.title}"
    end
  end

  def event_name
    EVENTS[self.event_id]
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "gregs-tranquil-cove.herokuapp.com/" : "localhost:3000"
    options
  end
end
