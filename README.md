#[Rap Kinda Smart][rkc]

##a [Rap Genius][rg] Clone

[rg]: http://www.rapgenius.com
[rkc]: http://www.rapkindasmart.com

##What is it?
Rap Genius is a website where you can add notes, called "annotations," to nearly anything. The idea is to better explain the thing you're adding notes to, to clarify a complex or vague sentence, or to shed light upon some poorly known fact.

##Technology Used
* [Heroku][heroku] hosts the app.
* The backend of the application is done entirely in Rails, which interfaces with the database, written in postgres.
* The frontend of the application is a combination of symantic HTML, handwritten CSS, Rails and Backbone. 
	* The Backbone is mostly on the actual document pages to allow for the displaying and other various CRUDing of the annotations themselves, though, in fact, the entire document page is written in backbone.
	* The other pages are largely written in a combination of symantic HTML and Rails's ERB templating methods. This allows for the pages to be dynamic and flexible.
* Voting on the annotations is accomplished through Single Table Inheritance. 
	* There is a vote table, and then there is a vote model. There is then an Upvote and Downvote model that inherit from their common parent. 
	* The votes are only ever accessed through the child models, but because they are almost exactly the same, there is no reason to separate them. 
	*Additionally, the minimal complexity of the implementation allows for an easy transition to polymorphism, were there anything else to vote on.
* The annotations, in addition to other things, is then ranked with a [Cron][cron] feature.
	* [Heroku][heroku] makes this both easy and hard.
			* Because the dynos eventually spin down, [the traditional rails/unix interfaces don't work][soheroku].
			* However, [Heroku gives us an addon][scheduler] that makes it very easy to do with just a rake task.
* Whenever an event of importance happens to one of the users, the system sends them a notification. 
	* The notifications are accomplished through polymorphic association.
	* This allows nearly anything to trigger a notification, and for them to be sent to anything from anything.
	* Their versitility is what makes them powerful and useful.
* The selection of text is done through a JS library called [Rangy][rangy].

[cron]: http://en.wikipedia.org/wiki/Cron
[rangy]: https://code.google.com/p/rangy/
[heroku]: http://www.heroku.com
[scheduler]: https://devcenter.heroku.com/articles/scheduler
[soheroku]: http://stackoverflow.com/questions/8619754/whenever-gem-running-cron-jobs-on-heroku



##ToDo
###Major Pieces

* Design a tour
* Finish implementing backbone + Rangy

###Minor pieces
* Get rid of junk -- There's a lot of JS hanging around that isn't needed and is throwing off my github stats.