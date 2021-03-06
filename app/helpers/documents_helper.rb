require "addressable/uri"
module DocumentsHelper
  def annotate_document(document, segments)
    return document.body if segments.empty?

    annotated_body = ""

    ranges = segments.keys.sort_by { |key| key.first }
    total_length = 0

    if ranges.first.first > 0
      annotated_body += document.substring(0, ranges.first.first)
    end

    ranges.each_with_index do |range, index|
      annotated = document.range_substring(range)
      anns = [*segments[range]]
      annotated_body += annotation_link(anns, annotated, index, range)

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

  def annotation_link(annotations, annotated, index, range)
    ids = []
    annotations.each do |ann|
      ids << ann.id
    end
    query_hash = Hash.new
    query_hash[:ids] = ids

    # a_url = annotation_url(annotations.first.id)
    # Bootstraps the ids of the annotations, so that it knows which one it's clicking on without expensive queries.
    # tags = "<a class='annotation-highlight annotation-link' id='#{index}' data-ids='#{ids.join(',')}' data-start-position='#{range.first}' data-end-position='#{range.last}' href='" + 
              # a_url + "?" + query_hash.to_query + "'>" + annotated + "</a>"
    tags = "<span class='annotation-highlight annotation-link' id='#{index}' data-ids='#{ids.join(',')}' data-start-position='#{range.first}' data-end-position='#{range.last}'>#{annotated}</span>"
    return tags
  end
end
