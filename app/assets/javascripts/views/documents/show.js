CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],
  annotationTemplate: JST['annotations/show'],
  className: 'document',

  initialize: function () {

    this.listenTo(CodeKindaSmart.doc.annotations, 'change', this.render)
    this.listenTo(CodeKindaSmart.doc, 'change', this.render)

    this.highlighter = rangy.createHighlighter();
    this.highlighter.addClassApplier(rangy.createCssClassApplier("highlight", {
      ignoreWhiteSpace: true,
      tagNames: ["span", "a"]
    }));
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
    $(".newAnnotation").remove()
    var ids = []
    ids = ids.concat(event.currentTarget.dataset.ids)
    console.log(ids);
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

    that.range = sel.getRangeAt(0);

    var lowEnd = sel.focusOffset < sel.anchorOffset ? sel.focusOffset : sel.anchorOffset;
    var highEnd = sel.focusOffset < sel.anchorOffset ? sel.anchorOffset : sel.focusOffset;

    var startIndex = that.selStartIndex(sel) + lowEnd;
    var endIndex = startIndex + (highEnd - lowEnd);

    that.start_location =  CodeKindaSmart.doc.attributes.body.indexOf(that.range)
    that.end_location =  that.start_location + that.range.toString().length;

    if ( that.highlighter.removeAllHighlights() == undefined ) {
      that.highlighter.highlightSelection("highlight");
      that.createButton(that.range);
    }
  },


  highlightSelectedText: function (range) {
    highlighter = rangy.createHighlighter();
    highlighter.addClassApplier(rangy.createCssClassApplier("highlight", {
      ignoreWhiteSpace: true,
      tagNames: ["span", "a"]
    }));

    highlighter.highlightSelection("highlight");
  },

  surroundRange: function (range) {
      if (range) {
        var el = document.createElement("span");
        el.style.backgroundColor = "#9F3BFF";
        el.style.color = "#fff"
        try {
          range.surroundContents(el);
          return true;
        } catch(ex) {
          return false;
        }
      }
  },

  createButton: function (range) {
    var that = this;
    that.annotationOffset = (that.finalY/2 + that.initialY/ 2) - 50 - $('.annotation-column').offset().top

    if($('.newAnnotation')[0] != undefined) {
      $(".newAnnotation").css("top", "=" + 0);
      $(".newAnnotation").css("top", "+=" + that.annotationOffset);
    } else {
      content = $("<div class='group newButton newAnnotation'> <a data-range='" + range + "' href=''> + </a> </div>")
      $(".annotation-column").append(content);
      $(".newAnnotation").css("top", "+=" + that.annotationOffset);
    }
  },

  newAnnotation: function() {
    event.preventDefault();
    if(CodeKindaSmart.currentUser){
     var view = new CodeKindaSmart.Views.AnnotationsForm({
      range: this.range,
      start_location: this.start_location,
      end_location: this.end_location
    });
    $(".newButton").remove()
    $(".annotation-column").append(view.render().$el);
    $(".form-annotation-wrapper").css("top", "+=" + this.annotationOffset);
      
    } else {
      $('.newButton').remove()
    }

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
