def beowulf

	beowulf = Document.create(title: "Beowulf", body: beowulf_body, author_id: @anon.id, user_id: @gergz.id)

	my_annotation = Annotation.create(title: "I love this poem", body: "Seriously, this is my favorite of all the great epic poems.", start_location: 0, end_location: 200, user_id: @greg.id, document_id: beowulf.id)

	@fake_users.each do |fake_user|
		UpVote.create(annotation_id: my_annotation.id, user_id: fake_user.id)
	end

end