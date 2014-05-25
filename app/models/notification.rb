class Notification < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  EVENTS = {
    1 => :new_annotation_on_document,
    2 => :new_upvote_on_annotation,
    3 => :new_downvote_on_annotation
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
    when :new_upvote_on_annotation
      upvote = self.notifiable
      annotation_url(upvote.annotation_id)
    when :new_downvote_on_annotation
      downvote = self.notifiable
      annotation_url(downvote.annotation_id)
    end
  end

  def text
    case self.event_name
    when :new_annotation_on_document
      annotation = self.notifiable
      annotation_user = annotation.user
      document = annotation.document

      "#{annotation_user.username} annotated your document #{document.title}"
    when :new_upvote_on_annotation
      upvote = self.notifiable
      upvote_user = upvote.user
      annotation = upvote.annotation
      document = annotation.document

      "#{upvote_user.username} upvoted your annotation #{annotation.title} on #{document.title }"
    when :new_downvote_on_annotation
      downvote = self.notifiable
      downvote_user = downvote.user
      annotation = downvote.annotation
      document = annotation.document

      "#{downvote_user.username} downvoted your annotation #{annotation.title} on #{document.title }"
    end
  end

  def event_name
    EVENTS[self.event_id]
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "www.rapkindasmart.com/" : "localhost:3000"
    options
  end
end
