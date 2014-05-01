CodeKindaSmart.Views.SegmentsIndex = Backbone.View.extend({

  template: JST['segments/index'],
  initialize: function () {
  },

  events: {
  	"click annotation-link" : "showAnnotation",
  	"click upvote" : "upVote",
  	"click downvote" : "downVote",
    "click save" : "saveAnnotation"
  },

  showAnnotation: function () {
    
  }



});
