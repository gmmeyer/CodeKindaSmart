#[Rap Kinda Smart][rkc]

##A Shameless [Rap Genius][rg] Clone

[rg]: http://www.rapgenius.com
[rkc]: http://www.rapkindasmart.com

##What is it?
[Rap Kinda Smart][rkc] is a website where you can add notes, called "annotations," to nearly anything. The idea is to better explain the thing you're adding notes to, to clarify a complex or vague sentence, or to shed light upon some poorly known fact.

##What are people saying about it?
* Me: "This is pretty neat!"
* My mom: "What is this? I don't understand it."
* The [New York Times][http://nytimes.com]: "No comment."

##Technology Used
* [Heroku][heroku] hosts the app.
* The backend of the application is done entirely in Rails, which interfaces with the database, written in postgres.
* The frontend of the application is a combination of symantic HTML, handwritten CSS, Rails and Backbone. 
	* The Backbone is mostly on the actual document pages to allow for the displaying and other various CRUDing of the annotations themselves, though, in fact, the entire document page is written in backbone.
	* The other pages are largely written in a combination of symantic HTML and Rails's ERB templating methods. This allows for the pages to be dynamic and flexible.
* Voting on the annotations is accomplished through Single Table Inheritance. 
	* There is a vote table, and then there is a vote model. There is then an Upvote and Downvote model that inherit from their common parent. 
	* The votes are only ever accessed through the child models, but because they are almost exactly the same, there is no reason to separate them. 
	* The minimal complexity of the implementation allows for an easy transition to polymorphism, were there anything else to vote on.
* The annotations, Users and Documents are ranked with a [Cron][cron] feature.
	* [Heroku][heroku] prevents traditional Rails/*nix implementations of Cron, as the [dynos eventually down][soheroku].
		* However, heroku's [scheduler addon][scheduler] is a reasonable replacement.
* Whenever an event of importance happens to one of the users, the system sends them a notification. 
	* The notifications are accomplished through polymorphic association.
	* This allows nearly anything to trigger a notification, and for them to be sent to anything from anything.
	* Their versitility is what makes them powerful and useful.
* The selection of text is now done through a browser's native selection methods.
	* I used to use the JS library [Rangy][rangy] for this.
	* Modern browsers don't need Rangy.

[cron]: http://en.wikipedia.org/wiki/Cron
[rangy]: https://code.google.com/p/rangy/
[heroku]: http://www.heroku.com
[scheduler]: https://devcenter.heroku.com/articles/scheduler
[soheroku]: http://stackoverflow.com/questions/8619754/whenever-gem-running-cron-jobs-on-heroku



##ToDo
###Major Pieces

* Design a tour
* Finish implementing backbone + Rangy
* Make every page look the same, the document page is the model.
* Simplify the CSS and the tags, there is no reason for having as many as I do.

##Liscense
Rap Kinda Smart is released under an [MIT Liscense][/LISCENSE]
---
Developed by [Greg Meyer][http://gmmeyer.com]