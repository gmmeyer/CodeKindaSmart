json.(@document, :title, :user_id, :author_id)
json.username @document.user.username
json.author @document.author.name
json.body 	simple_format(annotate_document(@document, @document.segments), {class: "document-paragraph"}, sanitize: false)