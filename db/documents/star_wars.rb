def star_wars(me)

	george_lucas = Author.create(name: "George Lucas")

	star_wars_iv = Document.create(title: "Star Wars IV: A New Hope", body: star_wars_body, author_id: george_lucas.id, user_id: me.id)

end