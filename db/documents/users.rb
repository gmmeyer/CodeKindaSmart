def create_users

	user_password = 'password'

	@fake_users = []

	100.times do |i|

		@fake_users << User.create(username: Faker::Internet.user_name, email: Faker::Internet.safe_email, password: user_password, password_confirmation: user_password)

	end

	@me = User.create(username: 'greg', email: 'greg@greg.com', password: 'password', password_confirmation: 'password')
	@greg = @me

	@gergz = User.create(username: "gergz", email: "gmeypop@gmail.com", password: "password", password_confirmation: "password")

end