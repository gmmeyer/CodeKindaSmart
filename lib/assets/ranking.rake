desc "This task is called by the Heroku scheduler add-on"
task :update_ranking => :environment do
	puts "Updating Ranking..."
	Document.update_score
	User.update_score
	Annotation.update_score
	puts "done."
end