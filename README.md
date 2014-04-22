#[Rap Genius][rg] Clone

[rg]: rapgenius,com

##ToDo
###Database

####Annotations
The annotations will be set up using a table for the annotations and then a join table between the annotation table and the document table.

The join table will store where in the document the annotation is referring to.

While there are more complex ways of doing this, the naive way seems to be the best way of actually accomplishing what I want to achieve.



####Changes to be made going along:
* Add an authors table to the database, remove the author field from documents and then add it to the authors table.
* Link the authors table with the users table, if there is a link.
  * This is good, because you can post shit that is not, so to speak, yours.