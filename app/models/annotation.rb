class Annotation < ActiveRecord::Base

  validates :title, :body, :user_id, :document_id, :start_location, :end_location, presence: true
  validate :length_check
  before_validation :sanitize_text

  belongs_to :document, inverse_of: :annotations, counter_cache: true
  belongs_to :user, inverse_of: :annotations, counter_cache: true

  has_many :upvotes, class_name: "UpVote", dependent: :destroy
  has_many :downvotes, class_name: "DownVote", dependent: :destroy

  has_many :notifications, as: :notifiable, inverse_of: :notifiable, dependent: :destroy

  after_commit :set_notification, on: [:create]

  def load_user_vote(current_user)
    if current_user
      downvote = downvotes.find_by(user_id: current_user.id) 
      upvote = upvotes.find_by(user_id: current_user.id)
      return @my_vote = downvote if downvote
      return @my_vote = upvote if upvote
    end

    @my_vote = nil
  end

  def builder
    Jbuilder.encode do |json|
      json.(self, :id, :title, :body, :user_id, :start_location, :end_location, :up_votes_count, :down_votes_count)
      json.username self.user.username
    end
  end

  def my_vote
    @my_vote
  end

  def range
    return (self.start_location..self.end_location)
  end


  # Ranking

  # Checks existence and then returns the score.
  def score

    if self.up_votes_count && self.down_votes_count
      return self.up_votes_count - self.down_votes_count

    elsif self.up_votes_count
      return self.up_votes_count

    elsif self.down_votes_count
      return (- self.down_votes_count)
    
    else
      return 0
    
    end
  end

  # Gets the score of the annotation, 
  # and transforms it into a rank 
  # by looking at the rank in a temporal manner. 
  # It is only a good score if it is recent.
  # And, that is because an old annotation 
  # can get a very high score.
  # However, its age should not be the only 
  # determining factor in that score,
  # which is why I chose to use this algorithm, 
  # rather than one that used
  # only the score.
  # This algorithm is strongly, very strongly, 
  # based off the reddit algorithm.

  # Ranking is looking not at what is hot in total,
  # but at what it hot that moment.

  def ranking

    s = self.score

    # Natural logarithms are the only logaritms that matter.
    # Why do math in base 10 when you can use base e?
    order = Math.log([s.abs, 1].max)

    if s > 0
      sign = 1
    elsif s < 0
      sign = -1
    else
      sign = 0
    end

    rank = (order * sign) + self.created_at.to_i / 45000

    rank
  end

  def self.update_ranking

    self.find_each do |annotation|
      annotation.rank = annotation.ranking
      annotation.save
    end

  end

  private

  def length_check
    if self.start_location == self.end_location
      add.errors("The length of your annotation must be greater than one letter")
    end
  end

  def set_notification
    notification = self.notifications.unread.event(:new_annotation_on_document).new
    notification.user = self.document.user
    notification.save
  end
  
  def sanitize_text
    self.body = Nokogiri::HTML(self.body)
    self.title = Nokogiri::HTML(self.title)
    self.body.xpath('/t').remove
    self.title = self.title.text
    self.body = self.body.text
  end
end