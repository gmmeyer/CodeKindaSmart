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
    event.preventDefault();

    console.log(event.currentTarget)



    // this._activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(id,
    //   function (annotation) {
    //     var view = new CodeKindaSmart.Views.AnnotationsShow({
    //       annotation: annotation
    //     });
    //     that._swapView(view)
    //   }
    // );


    
    // $(".annotation-column").append() // More to come, folks.
    // $(event.currentTarget)
    console.log(event)
  },

  renderAnnotation: function (annotation) {
    var content = this.annotationTemplate({
      annotation: this._annotation
    })
    this.$el.html(content);
    return this;
  },

  hideAnnotation: function () {
    $(".activeAnnotations").addClass("hidden")
    $(".activeAnnotations").removeClass("activeAnnotations")
  },


  upVote: function () {

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
