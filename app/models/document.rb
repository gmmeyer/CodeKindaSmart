class Document < ActiveRecord::Base
  include ActionView::Helpers::SanitizeHelper
  attr_accessor :annotation_segments, :segments, :document, :sorted_segments
  validates :title, :body, :user_id, :author_id, presence: true
  validates :title, uniqueness: true
  before_validation :sanitize_text

  belongs_to :user, inverse_of: :documents, counter_cache: true
  has_many :annotations, dependent: :destroy

  belongs_to :author, inverse_of: :documents, counter_cache: true

  include PgSearch
  # implement these: [:tsearch, :dmetaphone, :trigram]
  multisearchable against: [:title, :body]

  # Jbuilder

  def builder
    Jbuilder.encode do |json|
      json.(self, :title, :body, :user_id, :author_id)
      json.username self.user.username
      json.author self.author.name
    end
  end

  def segments_builder
    Jbuilder.encode do |json|
      sorted_segments = self.sort_segments

      json.segments sorted_segments do |segment|
        json.range segment.first
        json.annotation segment.last
      end
    end
  end

  # Substrings

  def substring(starting, ending)
    self.body[starting...ending]
  end

  def range_substring(range)
    self.body[range]
  end

  # Segments and Annotation

  def annotation_ranges
    anns = self.annotations
    annotation_hash = {}

    anns.each do |ann|
      annotation_hash[ann] = ann.range
    end

    annotation_hash
  end

  def sort_segments
    ranges = segments.keys.sort_by { |key| key.first }
    annotation_segments = segments
    ann_arr = []

    ranges.each do |range|
      annotation = annotation_segments[range]
      if annotation.kind_of?(Array)
        ann_arr << [[range.first, range.last], annotation.map{ |ann| ann.builder }]
      else
        ann_arr << [[range.first, range.last], [annotation.builder]]
      end
    end

    ann_arr
  end

  def segments
    segments = {}
    annotation_hash = self.annotation_ranges
    segments = overlap_loop(segments, annotation_hash)
    return segments
  end

  def overlap_loop(segments, annotation_hash)
    annotation_hash.each do |ann1, range1|
      no_overlap = true
      annotation_hash.each do |ann2, range2|
        next if ann1 == ann2
        overlap = (range1.to_a & range2.to_a)

        if overlap.empty?
          next
        else
          no_overlap = false
          overlap = ( (range1.to_a & range2.to_a).first..(range1.to_a & range2.to_a).last )
        end

        # I can factor out the ranges stuff, to a method that just finds ranges.
        new_seg = ( (range1.to_a - overlap.to_a & range1.to_a).first..
                    (range1.to_a - overlap.to_a & range1.to_a).last )
        segments = add_to_segment_hash(segments, overlap, ann1, new_seg)
      end

      if no_overlap
        segments[range1] = ann1
      end
    end

    segments
  end

  def add_to_segment_hash(segments, overlap, ann, new_seg)

    if overlap.first && segments[overlap]
      segments[overlap] = segments[overlap] << ann unless segments[overlap].include? ann
    elsif overlap.first
      segments[overlap] = [ann]
    end

    if new_seg.first && segments[new_seg]
      segments[new_seg] = segments[new_seg] << ann unless segments[new_seg].include? ann
    elsif new_seg.first
      segments[new_seg] = [ann]
    end

    segments
  end

  # Ranking

  # For a discussion on this algorithm
  # see my comments in the annotation model.
  # While the ranking itself is slightly different, 
  # the mechanism is quite similar. And I have 
  # purposefully retained the paralells.

  def score

    if self.annotations_count
      return self.annotations_count
    else
      return 0
    end

  end

  def ranking

    s = self.score

    # Natural logarithms are the only logaritms that matter.
    # Why do math in base 10 when you can use base e?
    order = Math.log([s, 1].max)

    if s > 0
      sign = 1
    else
      sign = 0
    end

    rank = (order * sign) + self.created_at.to_i / 45000

    rank
  end

  def self.update_ranking
    self.find_each do |document|
      document.rank = document.ranking
      document.save
    end
  end

  private
  def sanitize_text
    self.body = Nokogiri::HTML(self.body)
    self.title = Nokogiri::HTML(self.title)
    self.body.xpath('/t').remove
    self.title = self.title.text
    self.body = self.body.text
  end
end
