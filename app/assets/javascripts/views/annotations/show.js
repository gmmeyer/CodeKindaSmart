CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/index'],

  events: {
  	"click upvote" : "upVote",
  	"click downvote" : "downVote",
		"click save" : "saveAnnotation"
  },

  initialize: function () {
  	// add a listener here to listen for new annotations being added to the collection.
  } 
  

});
