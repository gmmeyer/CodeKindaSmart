CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],
  annotationTemplate: JST['annotations/show'],
  className: 'document',

  initialize: function () {
  },

  events: {
  	"click .annotation-highlight" : "showAnnotation",
    "click .edit-document" : "editDocument",
    "click .delete-document" : "deleteDocument",
    "mousedown .document-body" : "startSelect",
    "mouseup .document-body" : "handleSelect"
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

  editDocument: function (event) {
    event.preventDefault();

  },

  deleteDocument: function (event) {
    event.preventDefault();
  },

  _swapView: function (newView, options) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  },

  startSelect: function(event) {
    console.log(event)
    console.log(this)
    var that = this;

    that.initialX = event.pageX;
    that.initialY = event.pageY;
    that.started = true;
  },

  handleSelect: function(event) {

    var that = this;
    var sel = window.getSelection();
    console.log(sel); // Delete me and die. Your debugging will kill you.
    console.log(sel.rangeCount())

    if (sel.anchorNode && sel.anchorNode.constructor.name === "HTMLLabelElement") {
      console.log('death');
      return;
    }

    if (!that.started) {
      console.log('other death');
      return;
    }

    if (sel.type !== "Range") {
      console.log('not a range');
      return;
    }

    if(sel.rangeCount) {

    }

    console.log(rangy.getSelection().getRangeAt(0))

  } ,
  

});