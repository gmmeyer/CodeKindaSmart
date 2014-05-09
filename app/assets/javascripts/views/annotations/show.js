CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/show'],
  tagName: "div",



  events: {
  	"click .upvote" : "upVote",
  	"click .downvote" : "downVote",
  	"click .edit-annotation" : "editAnnotation",
		"click .save-annotation" : "saveAnnotation",
    "click .delete-annotation" : "deleteAnnotation"
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

  upVote: function (event) {
    event.preventDefault()
    console.log('upVote')
  },

  downVote: function (event) {
    event.preventDefault()
    console.log('downVote')
  },

  editAnnotation: function (event) {
    event.preventDefault()
    console.log('editAnnotation')
  },

  saveAnnotation: function (event) {
    event.preventDefault()
    console.log('saveAnnotation')
  },

  deleteAnnotation: function (event) {
    event.preventDefault();
    console.log('deleteAnnotation');
  }

});