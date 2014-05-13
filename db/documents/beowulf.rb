def beowulf

	beowulf = Document.create(title: "Beowulf", body: beowulf_body, author_id: @anon.id, user_id: @gergz.id)

	my_annotations = []

	titles = ["I  love this poem", "Why?"]
	bodies = ["Seriously, this is my favorite of all the great epic poems.", "I don't really know. I think it's because it's just so much more straightforward than the other epic poems. It gets to the point: we're insane, but we're going to go kill a god damn monster."]
	starts = [0, 250]
	ends = [200, 350]

	titles.length.times do |i|
		my_annotations << Annotation.create(title: titles[i], body: bodies[i], start_location: starts[i], end_location: ends[i], user_id: @me.id, document_id: beowulf.id)
	end

	User.all.each do |user|
		next if user == @me
		my_annotations.each do |my_annotation|
			UpVote.create(annotation_id: my_annotation.id, user_id: user.id)
		end
	end

end