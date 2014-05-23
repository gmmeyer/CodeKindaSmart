CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/show'],
  tagName: "div",

  initialize: function (options) {
    this.annotationOffset = options.annotationOffset;
    // this.annotations = this.activeAnnotations;
    this.annotations = [options.annotations];
    this.annotationId = options.annotationId;
  },

  events: {
  	"click .button .upvote" : "upVote",
  	"click .button .downvote" : "downVote",
  	"click .edit-annotation" : "editAnnotation",
		"click .save-annotation" : "saveAnnotation",
    "click .delete-annotation" : "deleteAnnotation"
  },

  render: function () {
    // I should move the placement variables to the render function
    // and then call the jquery here, so that I can rerender this when needed
    var content = this.template({
      annotationId: this.annotationId,
      annotations: this.annotations
    });
    this.$el.html(content);
    // $(".activeAnnotations").css("top", "+=" + this.annotationOffset);
    return this;
  },

  upVote: function (event) {
    event.preventDefault()
    currentTarget = event.currentTarget
    parentElement = currentTarget.parentElement
    if(CodeKindaSmart.currentUser.username){
      if(parentElement.classList.contains("my-vote")){
        $(parentElement).removeClass('my-vote');
      } else {
        $(".downvote p.button").removeClass('my-vote')
        $(parentElement).addClass('my-vote');
      }
    }
    var that = this;
    var attrs = this.$("form.upvote").serializeJSON();
    var xhReq = new XMLHttpRequest();
    xhReq.open("GET", "/api/annotations/" + this.annotations[0].id + "/upvote", false);
    xhReq.send();

  },

  downVote: function (event) {
    event.preventDefault()
    currentTarget = event.currentTarget
    parentElement = currentTarget.parentElement
    if(CodeKindaSmart.currentUser.username){
      if(parentElement.classList.contains("my-vote")){
        $(parentElement).removeClass('my-vote');
      } else {
        $(".upvote p.button").removeClass('my-vote')
        $(parentElement).addClass('my-vote');
      }
    }
    var that = this;
    var attrs = this.$("form.downvote").serializeJSON();
    var xhReq = new XMLHttpRequest();
    xhReq.open("GET", "/api/annotations/" + this.annotations[0].id + "/downvote", false);
    xhReq.send();

  },

  editAnnotation: function (event) {
    event.preventDefault()
    if(CodeKindaSmart.currentUser){
      var view = new CodeKindaSmart.Views.AnnotationsForm({
        annotation: this.annotations[0],
        annotationOffset: this.annotationOffset
      });
      $('.activeAnnotations').addClass('isHidden')
      $('.activeAnnotations').removeClass('activeAnnotations')
      $(".annotation-column").append(view.render().$el);
      $("form.new-annotation").css("top", "+=" + this.annotationOffset);
    }
  },

  deleteAnnotation: function (event) {
    event.preventDefault();
    var attrs = this.$(".form-delete-annotation").serializeJSON();
    var id = attrs.annotation.id
    console.log(id)

    CodeKindaSmart.doc.annotations.get(id).destroy({
      success: function () {
        CodeKindaSmart.doc.fetch()
      }
    })
  }

});