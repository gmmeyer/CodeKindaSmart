def beowulf

	beowulf = Document.create(title: "Beowulf", body: beowulf_body, author_id: @anon.id, user_id: @gergz.id)

	my_annotation = Annotation.create(title: "I love this poem", body: "Seriously, this is my favorite of all the great epic poems.", start_location: 0, end_location: 200, user_id: @greg.id, document_id: beowulf.id)

	User.all.each do |user|
		next if user == @greg
		UpVote.create(annotation_id: my_annotation.id, user_id: user.id)
	end

end