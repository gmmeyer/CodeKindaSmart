require "addressable/uri"
module DocumentsHelper
  def annotate_document(document, segments)
    return document.body if segments.empty?

    annotated_body = ""

    ranges = segments.keys.sort_by { |key| key.first }

    if ranges.first.first > 0
      annotated_body += document.substring(0, ranges.first.first)
    end

    ranges.each_with_index do |range, index|
      annotated = document.range_substring(range)
      anns = [*segments[range]]
      annotated_body += annotation_link(anns, annotated)

      if range == ranges.last && range.last < document.body.length - 1
        annotated_body += document.substring(range.last + 1, document.body.length)
      elsif range != ranges.last && range.last < ranges[index+1].first
        if ranges[index+1].first - range.last > 0
          annotated_body += document.substring(range.last + 1, ranges[index + 1].first)
        end
      end
    end
    
    return annotated_body
  end

  def annotation_link(annotations, annotated)
    ids = []
    annotations.each do |ann|
      ids << ann.id
    end
    query_hash = Hash.new
    query_hash[:ids] = ids

    a_url = annotation_url(annotations.first.id)
    return "<span class='annotation-highliht'><a class='annotation-link' href=" + a_url + "?" + query_hash.to_query + ">" + annotated + "</a></span>"
  end
end
