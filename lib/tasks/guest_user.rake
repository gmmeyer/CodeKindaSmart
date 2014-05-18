desc "This task is called by the Heroku scheduler add-on"
task :guest_user => :environment do
	puts "Cleaning Guest User Account..."

	def road_not_taken_body
		<<-HTML

			Two roads diverged in a yellow wood,
			And sorry I could not travel both
			And be one traveler, long I stood
			And looked down one as far as I could
			To where it bent in the undergrowth;

			Then took the other, as just as fair,
			And having perhaps the better claim,
			Because it was grassy and wanted wear;
			Though as for that the passing there
			Had worn them really about the same,

			And both that morning equally lay
			In leaves no step had trodden black.
			Oh, I kept the first for another day!
			Yet knowing how way leads on to way,
			I doubted if I should ever come back.

			I shall be telling this with a sigh
			Somewhere ages and ages hence:
			Two roads diverged in a wood, and I - 
			I took the one less traveled by
			And that has made all the difference.

		HTML
	end

	def fire_and_ice_body

		<<-HTML

			Some say the world will end in fire,
			Some say in ice.
			From what I've tasted of desire
			I hold with those who favor fire.
			But if I had to perish twice,
			I think I know enough of hate
			To say thay for destruction ice
			Is also great
			And would suffice.

		HTML

	end

	def going_for_water_body

		<<-HTML

			The well was dry beside the door,
			And so we went with pail and can
			Across the fields behind the house
			To seek the brook if still it ran;

			Not loth to have excuse to go,
			Because the autumn eve was fair
			(Though chill), because the fields were ours,
			And by the brook our woods were there.

			We ran as if to meet the moon
			That slowly dawned behind the trees,
			The barren boughs without the leaves,
			Without the birds, without the breeze.

			But once within the wood, we paused
			Like gnomes that hid us from the moon,
			Ready to run to hiding new
			With laughter when she found us soon.

			Each laid on other a staying hand
			To listen ere we dared to look,
			And in the hush we joined to make
			We heard, we knew we heard the brook.

			A note as from a single place,
			A slender tinkling fail that made
			Now drops that floated on the pool
			Like pearls, and now a silver blade.
		HTML

	end

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
	user = User.find_by(username: 'Guest')
	user.documents.destroy_all
	user.annotations.destroy_all

	user = User.create(username: 'Guest', password: 'Guest', email: 'guest@example.com', password_confirmation: 'Guest')

	robert_frost(user)

	puts "done."
end