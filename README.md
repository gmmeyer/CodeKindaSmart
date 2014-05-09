#[Rap Kinda Smart][rkc]

##a [Rap Genius][rg] Clone

[rg]: http://www.rapgenius.com
[rkc]: http://www.rapkindasmart.com

##What is it?
Rap Genius is a website where you can add notes, called "annotations," to nearly anything. The idea is to better explain the thing you're adding notes to, to clarify a complex or vague sentence, or to shed light upon some poorly known fact.

##Where is it?
[You can see it here]

##Technology Used
* The backend of the application is done entirely in Rails, which interfaces with the database, written in postgres.
* The frontend of the application is a combination of symantic HTML, handwritten CSS, Rails and Backbone. 
	* The Backbone is mostly on the actual document pages to allow for the displaying and other various CRUDing of the annotations themselves, though, in fact, the entire document page is written in backbone.
	* The other pages are largely written in a combination of symantic HTML and Rails's ERB templating methods. This allows for the pages to be dynamic and flexible.
* The votes for the Single Table Inheritance
* Polymorphic Association
* Backbone




##ToDo
###Major Pieces

* Finish implementing backbone
* Design a tour
* Do the ranking

##Minor Pieces
* CSS on new user page.
* Replace purple borders with yellow.
