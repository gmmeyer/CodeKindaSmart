module DocumentsHelper

	def annotate_document(document, annotations)

		return document.body if annotations.empty?

		annotated_body = ""

		if annotations.first.start_location >= 1
			annotated_body += document.substring(0, annotations.first.start_location) 
		end

		annotated_body = annotation_loop(document, annotations, annotated_body)

		annotated_body
	end

	def annotation_loop(document, annotations, annotated_body)

		annotations.each_with_index do |ann, index|
			before = document.body[0..ann.start_location - 1]
			annotated = document.body[ann.start_location..ann.end_location]

			annotated_body += annotation_link_start(ann, annotated)

			if ann == annotations.last && ann.end_location < document.body.length - 1
				annotated_body += document.substring(annotations.last.end_location + 1, document.body.length)

			elsif ann != annotations.last && ann.end_location < annotations[index + 1].start_location
				if annotations[index + 1].start_location - ann.end_location > 0

					annotated_body += document.substring(ann.end_location + 1, annotations[index + 1].start_location)
				end
			end
		end

		return annotated_body
	end

	def annotation_link(annotation, annotated)

		a_class = "annotation"
		a_class += " my_annotation" if current_user && current_user.id == annotation.user_id
		a_url = annotation_url(annotation.id)

		return "<span class='annotation'><a class='annotation-link' href=" + annotation_url(annotation.id) + ">" + annotated + "</a></span>"
	end

end