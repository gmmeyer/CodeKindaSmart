CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/index'],

  events: {
  	"click upvote" : "upVote",
  	"click downvote" : "downVote",
   "click save" : "saveAnnotation"
  },


  

});
