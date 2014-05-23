def ulysses(me)

	jj = User.create(username: "james_joyce", email: "james_joyce@hotmail.com", password: "fuckingbook", password_confirmation: "fuckingbook")

	jj_author = Author.create(name: "James Joyce", location: "irish", description: 'Irish')

	ulysses = Document.create(title: "Ulysses", body: ulysses_body, author_id: jj_author.id, user_id: jj.id)

	Annotation.create(title: "So, that's why", body: "Even though I never read the book, I used it here as a showcase.", start_location: 60, end_location: 110, document_id: ulysses.id, user_id: me.id)

	Annotation.create(title: "Why I uploaded this.", body: "This book is gigantic, I uploaded this to show that my database could handle a book that is, according to Wikipedia, \"265,000 words in length,\", and that \"uses a lexicon of 30,030 words\" It shows the flexibility of the implementation.", start_location: 0, end_location: 50, document_id: ulysses.id, user_id: me.id)

end