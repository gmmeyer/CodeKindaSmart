module DocumentsHelper

	def annotate_document(id)

		@document = Document.find(id)
		@annotations = Document.annotations.order("start_location DESC")

		return @document.body if @annotations.empty?

		annotated_body = ""

		annotated_body = @document.body[0, @annotations.first.start_location - 1] if @annotations.first.start_location >= 1

		@annotations.each_with_index do |ann, i|

			annotation_loop(ann, index)

		end

		annotated_body
	end

	def annotation_loop(ann, index)

		before = @document.body[0, ann.start_location - 1]
		annotated = @document.body[ann.start_location, ann.end_location]

		annotated_body += annotation_link_start(ann) + annotated + "</a>"

		if ann == @annotations.last && ann.end_location < @document.body.length - 1
			annotated_body += @document.body[@annotations.last.end_location, -1]				
		elsif ann != @annotations.last && ann.end_location < @annotations[i+1].start_location
			if ann.end_location - @annotations[i+1].start-location > 1
				annotated_body += @document.body[ann.end_location + 1, @annotations[i + 1].start_location - 1]
			else
				annotated_body += @document.body[ann.end_location + 1]
			end
		end

	end

	def annotation_link_start(annotation)

		a_class = "annotation"
		a_class += " my_annotation" if annotation.user_id == current_user.id

		return URI.escape(<<-HTML)
			<a class="<%=a_link%>" href="<%=annotation(annotation.id)%>">
		HTML
	end
end