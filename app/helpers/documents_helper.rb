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

		puts annotated_body

		return annotated_body
	end

	def annotation_link(annotations, annotated)
		ids = "("
		annotations.each do |ann|
			ids += ann.id.to_s
			ids += "," unless ann == annotations.last
		end
		ids += ")"


		a_class = "annotation"
		# a_class += " my_annotation" if current_user && current_user.id == annotation.user_id
		a_url = annotation_url(annotations.first.id)

		return "<span class='annotation'><a class='annotation-link' href=" + a_url +"?ids=#{ids}" + ">" + annotated + "</a></span>"
	end

end