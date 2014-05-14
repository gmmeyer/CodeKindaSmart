json.users User.order('rank DESC').first(10)
json.documents Document.order('rank DESC').first(10)
json.annotations Annotation.order('rank DESC').first(10)
json.new_documents Document.order('created_at DESC').first(5)