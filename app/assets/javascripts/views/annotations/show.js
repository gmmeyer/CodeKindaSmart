CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/show'],
  tagName: "div",



  events: {
  	"click .upvote" : "upVote",
  	"click .downvote" : "downVote",
  	"click .edit" : "editAnnotation", 
		"click .save" : "saveAnnotation"
  },

  initialize: function (options) {
    this.annotationId = options.annotationId
  },

  render: function () {
    var content = this.template({
      annotationId: this.annotationId
    });
    this.$el.html(content);
    return this;
  },
});