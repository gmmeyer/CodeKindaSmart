json.(@annotation, :id, :title, :body, :user_id, :start_location, :end_location, :up_votes_count, :down_votes_count)

json.user_vote @annotation.load_user_vote(current_user)
json.username @annotation.user.username