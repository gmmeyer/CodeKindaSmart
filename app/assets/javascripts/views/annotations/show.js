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
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },
});