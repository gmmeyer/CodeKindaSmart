desc "This task is called by the Heroku scheduler add-on"
task :update_ranking => :environment do
	puts "Updating Ranking..."
	Document.update_ranking
	User.update_ranking
	Annotation.update_ranking
	puts "done."
end