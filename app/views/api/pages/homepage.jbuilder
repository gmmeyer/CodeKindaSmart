json.users User.order('rank DESC').first(10)

json.documents Document.includes(:author).order('rank DESC').first(10) do |document|

	json.document document
	json.author document.author

end

json.annotations Annotation.includes(:user).order('rank DESC').first(10) do |annotation|
	json.annotation annotation
	json.user annotation.user
end

json.new_documents Document.includes(:author).order('created_at DESC').first(5) do |document|
	json.document document
	json.author document.author
end