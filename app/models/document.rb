class Document < ActiveRecord::Base
  attr_accessor :annotation_segments
  validates :title, :body, :user_id, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :user
  has_many :annotations, dependent: :destroy
  belongs_to :author, inverse_of: :documents, counter_cache: true

  def substring(starting, ending)
    self.body[starting...ending]
  end

  def range_substring(range)
  	self.body[range]
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


end