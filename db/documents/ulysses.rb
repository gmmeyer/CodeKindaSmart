def ulysses(me)

	jj = User.create(username: "james_joyce", email: "james_joyce@hotmail.com", password: "fuckingbook", password_confirmation: "fuckingbook")

	jj_author = Author.create(name: "James Joyce", location: "irish", description: 'Irish')

	ulysses = Document.create(title: "Ulysses", body: ulysses_body, author_id: jj_author.id, user_id: jj.id)

	Annotation.create(title: "my god...", body: "why did I upload this book? I've never even read it.", start_location: 0, end_location: ulysses_body.length - 1, document_id: ulysses.id, user_id: me.id)

end