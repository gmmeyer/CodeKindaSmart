json.segments @sorted_segments do |segment|
  json.range segment.first
  json.annotation segment.last
end