json.(@document, :title, :body, :user_id, :author_id)
json.username @document.user.username
json.author @document.author.name