def cross_of_gold(me, gergz, fake_users)

	william_jennings_bryan = Author.create(name: "William Jennings Bryan", location: "Minnesota", description: "A three time losing presidential candidate for the democratic party, William Jennings Bryan was both the greatest orator of his era, and one of the worst politicians. He started his national career by giving the Cross of Gold speech at the Democratic National Convention in 1896, which lead the convention to nominate him nearly by acclimation, making him the (still) yougest presidentail nominee ever at the age of 36. He would end it, paradoxically, on the wrong side of history, by assaulting the teaching of evolution in the Scopes Monkey Trial.")

	cross_of_gold = Document.create(body: cross_of_gold_body, author_id: william_jennings_bryan.id, title: "Cross of Gold (speech)", summary: "The most famous political speech in American history.", release_date: 1896, user_id: gergz.id)

	Annotation.create(start_location: 0, end_location: 10, title: "This speech just goes on forever", body: "just, like, really.", document_id: cross_of_gold.id, user_id: me.id)


	anns_t = ["This is the most famous speech" "It won him the nomination" "It was unique"]
	anns_b = ["ever delivered by an american politician.", "It was almost instant, by proclimation.", "Nothing like it ever happened before, or again"]

	starts = [100, 500, 700]
	ends = [200, 600, 800]

	3.times do |i|
		Annotation.create( user_id: fake_users[i].id, title: anns_t[i], body: anns_b[i], document_id: cross_of_gold.id, start_location: starts[i], end_location: ends[i] )
	end

end