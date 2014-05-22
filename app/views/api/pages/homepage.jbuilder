json.users User.order('rank DESC').first(10)

json.documents Document.includes(:author).order('rank DESC').first(10) do |document|

	json.document do 
		json.title document.title
		json.annotations_count document.annotations_count
		json.id document.id
	end

	json.author document.author

end

json.annotations Annotation.includes(:user).order('rank DESC').first(10) do |annotation|
	
	json.annotation do 
		json.title annotation.title
		json.down_votes_count annotation.down_votes_count
		json.up_votes_count annotation.up_votes_count
		json.document_id annotation.document_id
	end

	json.user annotation.user
end

json.new_documents Document.includes(:author).order('created_at DESC').first(5) do |document|

	json.document do 
		json.title document.title
		json.annotations_count document.annotations_count
		json.id document.id
	end

	json.author document.author
end