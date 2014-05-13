def gpl

	fsf = Author.create(name: "Free Software Foundation", location: "Boston", description: "Promoting the right to free software.")

	fsf_user = User.create(username: "fsf", email: 'fsf@fsf.com', password: 'password', password_confirmation: 'password')

	gnugpl = Document.create(body: gpl_body, author_id: fsf.id, title: "GNU GPL", summary: "GNU GPL.", release_date: 2007, user_id: fsf_user.id)

	titles = ["The GPL: Part 1", "The GPL: Part 2", "The GPL: Part 3", "The GPL: Part 4", "The GPL: Part 5"]

	gpl_annotations = [
		'The GNU GPL is a liscense for free software. Developed by Richard Stallman and the Free Software Foundation in order to promote both the open use of free software and the adoption of the free software philosophy by those who would create free software.', 
		"Richard Stallman was already notable for creating EMACS, and thus starting the editor wars. While most sensible developers know that ed is the standard editor, some silly ones had a war over which of the two inferior editors to use: vim or emacs.", 
		"The liscense was revolutionary, as it allowed people to release their programs both free of charge and with the full source code.", 
		"However, they could not charge for the program released under the liscense. This prompted a whole new industry to pop up around free software. Lead by people like VA Linux, Red Hat, Caldera, and many others (those were just the distributers), a new economy based upon services, rather than products, began to emerge in software. This new economy was not only revolutionary in the manner in which it was organized, but it also bled into countless other industries.", 
		"Today, we see the effects of this revolution everywhere. This website, for instance, was built entirely on free and open source software (FOSS). Even the behemoth, Microsoft, has now released its immensely popular Office software, for mobile devices, entirely free of charge (though not open source, of course)."
	]

	start_locations = [1,20,40,60,80]
	end_locations = [10,30,50,70,90]

	gpl_annotations.length.times do |i|

		Annotation.create( user_id: @me.id, title: titles[i], body: gpl_annotations[i], document_id: gnugpl.id, start_location: start_locations[i], end_location: end_locations[i] )

	end
end