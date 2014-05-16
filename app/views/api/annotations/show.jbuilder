json.(@annotation, :title, :body, :user_id, :start_location, :end_location, :up_votes_count, :down_votes_count)
json.id @annotation.id
puts @annotation.title

json.user_vote @annotation.load_user_vote(current_user).class
json.username @annotation.user.username
json.score @annotation.score