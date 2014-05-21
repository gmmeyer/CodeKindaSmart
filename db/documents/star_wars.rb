def star_wars(me)

	george_lucas = Author.create(name: "George Lucas")

	star_wars_iv = Document.create(title: "Star Wars IV: A New Hope", body: star_wars_body, author_id: george_lucas.id, user_id: me.id)

	Annotation.create(title: "This title sequence", user_id: me.id, document_id: star_wars_iv.id, start_location: 0, end_location: 48, body: "Really could not get a whole lot better. It's so good. Just, so good.")

end