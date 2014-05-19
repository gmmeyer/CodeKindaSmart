desc "This task is called by the Heroku scheduler add-on"
task :guest_user => :environment do
	puts "Cleaning Guest User Account..."

	user = User.find_by(username: 'Guest')
	frost = Author.find_by(name: 'Robert Frost')
	user.documents.each do |document|
		if document.author_id != frost.id
			document.delete()
		end
	end

	user.annotations.destroy_all

	puts "done."
end