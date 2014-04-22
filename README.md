#[Rap Genius][rg] Clone

[rg]: rapgenius,com

##ToDo
###Database

####Annotations
How should I set up the database to actually store the annotations?

This is the main computational problem that I have. There are a few solutions that I've seen. And, it seems like any of them could be good. I could just store them as straight up text, and then use another database to log where in the text field the annotations are. I think that's suboptimal, but that's probably what I will use at first. However, there are some other, better, ways to do this.

* There are a few ways to do this in postgresql. psql has document handlers, and even an XML field that I could use to store the annotations. This could be useful, but I think that it might actually decrease some of the functionality of the database. Though, it won't decrease all of that functionality.
* A better way to do this, probably, is to use the JSON storage type in PSQL. This is something that I need to read a lot more about, though. There's a lot of nuance here.



####Changes to be made going along:
* Add an authors table to the database, remove the author field from documents and then add it to the authors table.
* Link the authors table with the users table, if there is a link.
  * This is good, because you can post shit that is not, so to speak, yours.