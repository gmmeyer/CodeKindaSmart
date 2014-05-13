def create_users

	@fake_users = []

	100.times do |i|

		@fake_users << User.create(username: Faker::Internet.user_name, email: Faker::Internet.safe_email, password: user_passwords[1], password_confirmation: user_passwords[1])

	end

	@me = User.create(username: 'greg', email: 'greg@greg.com', password: 'password', password_confirmation: 'password')

	@gergz = User.create(username: "gergz", email: "gmeypop@gmail.com", password: "password", password_confirmation: "password")

end