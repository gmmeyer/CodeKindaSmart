CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/index'],

  events: {
  	"click .upvote" : "upVote",
  	"click .downvote" : "downVote",
  	"click .edit" : "editAnnotation", 
		"click .save" : "saveAnnotation"
  },

  initialize: function () {
  	// add a listener here to listen for new annotations being added to the collection.
    // How do I ensure to trigger this at the right place?
  } 
  

});