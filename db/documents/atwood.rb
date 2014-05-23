def atwood(me,guest,fake_users)

	m_atwood = Author.create(name: "Margaret Atwood", description: "A very famous feminist author.")

	hook = Document.create(title: "You Fit Into Me", user_id: me.id, author_id: m_atwood.id, body: hook_body)

	hook_ann = Annotation.create(title: "The hook is outdated", body: "Hook in eye fasteners used to be commonplace, everywhere, when the poem was written. But, now, they are essentially only found on the back of bra straps.", user_id: guest.id, document_id: hook.id, start_location: 16, end_location: 39)

	fake_users.sample(3).each do |user|

		UpVote.create(user_id: user.id, annotation_id: hook_ann.id)

	end

end