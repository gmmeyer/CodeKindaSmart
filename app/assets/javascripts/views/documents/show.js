CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],
  annotationTemplate: JST['annotations/show'],

  initialize: function () {

  },

  events: {
  	"click .annotation-highlight" : "showAnnotation",
    "click .upvote" : "upVote",
    "click .downvote" : "downVote",
    "click .edit" : "editAnnotation",
    "click .save" : "saveAnnotation",
    "click .standalone-document" : "hideAnnotation"
  },


  render: function () {
  	var content = this.template({
  		doc: this.model
  	});
  	this.$el.html(content);
  	return this;
  },

  showAnnotation: function (event) {
    event.preventDefault();
    var ids = event.currentTarget.dataset.ids
    var annotationOffset = event.currentTarget.offsetTop - $('.annotation-column').offset().top
    that = this;

    $('.activeAnnotations').remove()

    CodeKindaSmart.activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(ids,
      function (annotationOffset) {
        var view = new CodeKindaSmart.Views.AnnotationsShow();
        $(".annotation-column").append(view.render().$el);
        $(".annotations").addClass("activeAnnotations");
        $(".activeAnnotations").css("top", "+=200");
        CodeKindaSmart.annotationsActive = true
      }
    );
  },

  renderAnnotation: function () {
    var content = this.annotationTemplate({
      annotations: this.activeAnnotations
    })
    this.$el.html(content);
    return this;
  },

  hideAnnotation: function (event) {



  },


  upVote: function () {
    // this.activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(id,
    //   function (annotation) {
    //     var view = new CodeKindaSmart.Views.AnnotationsShow({
    //       annotation: annotation
    //     });
    //     that._swapView(view)
    //   }
    // );
  },

  downVote: function () {

  },

  editAnnotation: function () {

  },

  saveAnnotation: function () {

  },

  _swapView: function (newView, options) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
  

});
    // this._activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(id,
    //   function (annotation) {
    //     var view = new CodeKindaSmart.Views.AnnotationsShow({
    //       annotation: annotation
    //     });
    //     that._swapView(view)
    //   }
    // );