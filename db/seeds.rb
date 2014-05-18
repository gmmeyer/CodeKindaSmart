# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@anon = Author.create(name: "Anonymous")

require_relative('documents/index')

cross_of_gold
gpl
ulysses
beowulf


Document.update_ranking
User.update_ranking
Annotation.update_ranking