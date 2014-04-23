module DocumentsHelper

	def annotate_document(id)

		@document = Document.find(id)
		@annotations = @document.annotations.order("start_location ASC")

		return @document.body if @annotations.empty?

		annotated_body = "<p class='document-body group'>"

		if @annotations.first.start_location >= 1
			annotated_body += @document.body[0, @annotations.first.start_location] 
		end

		annotated_body = annotation_loop(annotated_body)

		annotated_body
	end

	def annotation_loop(annotated_body)

		@annotations.each_with_index do |ann, index|
			before = @document.body[0, ann.start_location - 1]
			annotated = @document.body[ann.start_location, ann.end_location]

			annotated_body += annotation_link_start(ann) + annotated + "</a></div>"

		if ann == @annotations.last && ann.end_location < @document.body.length - 1

				annotated_body += @document.body[@annotations.last.end_location, 
					@document.body.length]

			elsif ann != @annotations.last && ann.end_location < @annotations[index + 1].start_location
				if @annotations[index + 1].start_location - ann.end_location > 1

					annotated_body += @document.body[ann.end_location + 1, 
						@annotations[index + 1].start_location]

				else
					annotated_body += @document.body[ann.end_location + 1]
				end
			end
		end

		annotated_body += "</p>"

		return annotated_body
	end

	def annotation_link_start(annotation)

		a_class = "annotation"
		a_class += " my_annotation" if current_user && current_user.id == annotation.user_id
		a_url = annotation_url(annotation.id)

		anchor_tag = "<div class='annotation'><a class='annotation-link' href=" + annotation_url(annotation.id) + ">"

		# anchor_tag = URI.escape(<<-HTML)
		# 	<a class="annotation-link" href=annotation_url(annotation.id)>
		# HTML

		return anchor_tag
	end
end