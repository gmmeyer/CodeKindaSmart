def robert_frost(guest_user)

	robert_frost = Author.create(name: "Robert Frost")

	road = Document.create(title: "The Road Not Taken", author_id: robert_frost.id, body: road_not_taken_body, user_id: guest_user.id)

	fire = Document.create(title: "Fire And Ice", author_id: robert_frost.id, body: fire_and_ice_body, user_id: guest_user.id)

	water = Document.create(title: "Going For Water", author_id: robert_frost.id, body: going_for_water_body, user_id: guest_user.id)

	titles = ['I love Robert Frost', "Robert Frost is amazing", "Do Robert Frost's poems mean anything?"]

	bodies = ['This is such a beautiful poem', "Everyone loves Robert Frost.", "I don't know, but it doesn't matter."]

	starts = [0, 50, 100]

	ends = [100, 150, 200]

	[road, fire, water].each_with_index do |poem, i|

		user = User.order("RANDOM()").first

		Annotation.create(title: titles[i], body: bodies[i], document_id: poem.id, user_id: user.id, start_location: starts[i], end_location: ends[i])

	end



end