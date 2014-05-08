CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],
  annotationTemplate: JST['annotations/show'],

  initialize: function () {
  },

  events: {
  	"click .annotation-highlight" : "showAnnotation"//,
    // "click .upvote" : "upVote",
    // "click .downvote" : "downVote",
    // "click .edit" : "editAnnotation",
    // "click .save" : "saveAnnotation"
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
    $('.activeAnnotations').addClass('isHidden')
    $('.activeAnnotations').removeClass('activeAnnotations')
    var ids = event.currentTarget.dataset.ids
    this.annotationId = event.currentTarget.id
    this.annotationOffset = event.currentTarget.offsetTop - $('.annotation-column').offset().top
    that = this;

    if ($('#ann-' + this.annotationId)[0] != undefined) {
      $('#ann-' + this.annotationId).removeClass("isHidden")
      $('#ann-' + this.annotationId).addClass('activeAnnotations')
    } else {
      CodeKindaSmart.activeAnnotations = CodeKindaSmart.doc.annotations.getOrFetch(ids,
        function (activeAnnotations) {
          var view = new CodeKindaSmart.Views.AnnotationsShow({
            annotationId: that.annotationId
          });
          $(".annotation-column").append(view.render().$el);
          $(".activeAnnotations").css("top", "+=" + that.annotationOffset);
          CodeKindaSmart.annotationsActive = true
        }
      );

    }

  },

  renderAnnotation: function () {
    var content = this.annotationTemplate({
      annotations: this.activeAnnotations
    })
    this.$el.html(content);
    return this;
  },


  // upVote: function () {
  // },

  // downVote: function () {
  // },

  // editAnnotation: function () {
  // },

  // saveAnnotation: function () {
  // },

  _swapView: function (newView, options) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }
  

});