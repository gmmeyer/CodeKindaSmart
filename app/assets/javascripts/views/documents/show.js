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
    "mouseup .document-body" : "handleSelect",
    "click .newAnnotation" : "newAnnotation"
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
    var that = this;

    that.initialX = event.pageX;
    that.initialY = event.pageY;
    that.started = true;
  },

  handleSelect: function(event) {

    var that = this;

    that.finalX = event.pageX
    that.finalY = event.pageY

    $('.activeAnnotations').addClass('isHidden')
    $('.activeAnnotations').removeClass('activeAnnotations')
    var sel = window.getSelection();
    // console.log(sel); // Delete me and die. Your debugging will kill you.

    if (sel.anchorNode && sel.anchorNode.constructor.name === "HTMLLabelElement") {
      return;
    }

    if (!that.started) {
      return;
    }

    if (sel.type !== "Range") {
      return;
    }

    var range = sel.getRangeAt(0);

    var lowEnd = sel.focusOffset < sel.anchorOffset ? sel.focusOffset : sel.anchorOffset;
    var highEnd = sel.focusOffset < sel.anchorOffset ? sel.anchorOffset : sel.focusOffset;

    var startIndex = this.selStartIndex(sel) + lowEnd;
    var endIndex = startIndex + (highEnd - lowEnd);

    that.start_location = CodeKindaSmart.doc.attributes.body.indexOf(range)
    that.end_location = that.start_location + range.toString().length;
    console.log(that.start_location)
    console.log(that.end_location)

    that.createButton(sel)
  },


  surroundRange: function (range) {
      if (range) {
          var el = document.createElement("span");
          el.style.backgroundColor = "#9F3BFF";
          el.style.color = "#fff"
          try {
              range.surroundContents(el);
          } catch(ex) {
          }
      }
  },

  createButton: function (sel) {
    var that = this;
    this.annotationOffset = (that.finalY/2 + that.initialX/ 2) - 100 - $('.annotation-column').offset().top

    console.log('boo')

    if($('.newAnnotation')[0] != undefined) {
      $(".newAnnotation").css("top", "=" + that.annotationOffset);
      $(".newAnnotation").css("top", "+=" + that.annotationOffset);
    } else {
      content = $("<div class='group newAnnotation'> <a href=''> + </a> </div>")
      console.log(content.html())
      $(".annotation-column").append(content);
      $(".newAnnotation").css("top", "+=" + that.annotationOffset);
    }
  },

  newAnnotation: function(sel) {
    event.preventDefault();
  },

  selStartIndex: function(sel) {
    var node = sel.anchorNode.previousSibling;
    var annRange = "";


    while (node) {

      if (node.nodeType === 3) {
        annRange += node.data;
      } else {
        var $node = $(node).clone();
        var $div = $("<div></div>");
        $div.append($node);
        annRange += $div.html();
      }



      node = node.previousSibling;
      if (node === undefined) {
        break;
      }
    }

    return annRange.length
  }  

});