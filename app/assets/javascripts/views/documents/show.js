CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],
  annotationTemplate: JST['annotations/show'],

  events: {
  	"click .annotation-highlight" : "showAnnotation",
    "click .upvote" : "upVote",
    "click .downvote" : "downVote",
    "click .edit" : "editAnnotation",
    "click .save" : "saveAnnotation",
    "click .hide body" : "hideAnnotation"
  },


  render: function () {
  	var content = this.template({
  		doc: this.model
  	});
  	this.$el.html(content);
  	return this;
  },

  showAnnotation: function (event) {
    event.preventDefault()
    
    // $(".annotation-column").append() // More to come, folks.
    $(event.currentTarget)
    console.log(event)
  },

  hideAnnotation: function () {
    $(".activeAnnotations").addClass("hidden")
    $(".activeAnnotations").removeClass(".activeAnnotations")
  },

  renderAnnotation: function (annotation) {
    var content = this.annotationTemplate({
      annotation: this.whatever
    })
  },

  upVote: function () {

  },

  downVote: function () {

  },

  editAnnotation: function () {

  },

  saveAnnotation: function () {

  }
  

});
