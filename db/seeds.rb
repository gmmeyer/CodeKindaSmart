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

  User.create(username: user_names[i] + i.to_s, email: i.to_s + user_emails[i],
    password: user_passwords[i], password_confirmation: user_passwords[i])

end

User.create(username: 'greg', email: 'greg@greg.com', password: 'password', password_confirmation: 'password')

me = User.find_by(username: 'greg')


docs = Document.new

titles = Array.new(3,'asdf')
bodies = Array.new(3, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor incididunt ut labore et doloremagna aliqua. Ut enim ad minim veniam, quis nostrudexercitation ullamco laboris nisi ut aliquip ex eacommodo consequat. Duis aute irure dolor inreprehenderit in voluptate velit esse cillum dolore eufugiat nulla pariatur. Excepteur sint occaecat cupidatatnon proident, sunt in culpa qui officia deserunt mollitanim id est laborum.')

3.times do |i|

  Document.create(title: i.to_s + titles[i], body: i.to_s + bodies[i], user_id: me.id)

end

annotations = Array.new(3, "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Id, unde, in deserunt at voluptate aperiam beatae facere optio vero consectetur voluptates ullam illum natus soluta cum corrupti iusto accusamus possimus!")
start_locations = [1,20,30]
end_locations = [10, 29, 40]
titles = ['so so good', 'penisfish', 'genius!']


doc = Document.all.first


3.times do |i|
	Annotation.create(start_location: start_locations[i], end_location: end_locations[i], user_id: me.id, document_id: doc.id, title: titles[i], body: annotations[i] )
end