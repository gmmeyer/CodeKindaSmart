CodeKindaSmart.Views.AnnotationsShow = Backbone.View.extend({

  template: JST['annotations/show'],
  tagName: "div",

  initialize: function (options) {
    console.log(options)
    this.annotationOffset = options.annotationOffset;
    this.annotations = this.activeAnnotations;
  },

  events: {
  	"click .upvote" : "upVote",
  	"click .downvote" : "downVote",
  	"click .edit-annotation" : "editAnnotation",
		"click .save-annotation" : "saveAnnotation",
    "click .delete-annotation" : "deleteAnnotation"
  },

  initialize: function (options) {
    this.annotationId = options.annotationId;
    this.annotations = [options.annotations];
  },

  render: function () {
    var content = this.template({
      annotationId: this.annotationId,
      annotations: this.annotations
    });
    this.$el.html(content);
    return this;
  },

  upVote: function (event) {
    event.preventDefault()

  },

  downVote: function (event) {
    event.preventDefault()

  },

  editAnnotation: function (event) {
    event.preventDefault()
    CodeKindaSmart.activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch([this.annotationId],
      function (activeAnnotations) {
        if(CodeKindaSmart.currentUser){
         var view = new CodeKindaSmart.Views.AnnotationsForm({
          annotation: this.annotations[0],
          annotationOffset: this.annotationOffset
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
    var attrs = this.$(".form-delete-annotation").serializeJSON();
    var id = attrs.annotation.id
    console.log(id)

    CodeKindaSmart.doc.annotations.get(id).destroy({
      success: function () {
        CodeKindaSmart.doc.fetch({
          success: function () {
            console.log('here')
          }
        })
      }
    })
  }

});