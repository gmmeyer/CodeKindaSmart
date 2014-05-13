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
    console.log(this.annotationId);
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
    CodeKindaSmart.activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(this.annotationId,
      function (activeAnnotations) {
        if(CodeKindaSmart.currentUser){
         var view = new CodeKindaSmart.Views.AnnotationsForm({
          annotation: activeAnnotations
        });
        $('.activeAnnotations').addClass('isHidden')
        $('.activeAnnotations').removeClass('activeAnnotations')

        $(".annotation-column").append(view.render().$el);
        $(".form-annotation-wrapper").css("top", "+=" + this.annotationOffset); 
        } else {
          $('.newButton').remove()
        }
      }
    )
  },

  deleteAnnotation: function (event) {
    event.preventDefault();
    var attrs = this.$("form.delete-annotation").serializeJSON();

    annotation = CodeKindaSmart.doc.annotations.getOrFetch(this.annotationId,
      function(annotation) {
        annotation.destroy()   
      }
    )
  }

});