# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_names = Array.new(3,'asdfasdf')
user_emails = Array.new(3,'test@test.test')
user_passwords = Array.new(3,'password')

3.times do |i|

  User.create(username: user_names[i] + i.to_s, email: i.to_s + user_emails[i], password: user_passwords[i], password_confirmation: user_passwords[i])

end

fake_users = []

20.times do |i|

	fake_users << User.create(username: Faker::Internet.user_name, email: Faker::Internet.safe_email, password: user_passwords[1], password_confirmation: user_passwords[1])

end



User.create(username: 'greg', email: 'greg@greg.com', password: 'password', password_confirmation: 'password')

me = User.find_by(username: 'greg')

gergz = User.new(username: "gergz", email: "gmeypop@gmail.com", password: "password", password_confirmation: "password")
gergz.save

author_names = Array.new(3, "Michael")
author_location = Array.new(3, "New York")

3.times do |i|
	Author.create(name: author_names[i], location: author_location[i])
end

load('./seeds/cross_of_gold.rb')
load('./seeds/ulysses.rb')
load('./seeds/gpl.rb')
