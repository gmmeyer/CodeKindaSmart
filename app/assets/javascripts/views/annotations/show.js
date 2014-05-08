CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/show'],
  tagName: "div",



  events: {
  	"click .upvote" : "upVote",
  	"click .downvote" : "downVote",
  	"click .edit" : "editAnnotation", 
		"click .save" : "saveAnnotation"
  },

  initialize: function () {
  	// add a listener here to listen for new annotations being added to the collection.
    // How do I ensure to trigger this at the right place?
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },
});