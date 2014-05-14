CodeKindaSmart.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

	routes: {
		'documents/:document_id/annotations/:id': 'showAnnotations',
		'documents/:id' : 'showDocument',
		'' : 'showHomepage'
	},

	annotationIndex: function () {
		var view = new CodeKindaSmart.Views.AnnotationsIndex({
			collection: CodeKindaSmart.annotations
		});
		this._swapView(view);
	},

	showAnnotations: function (document_id, id) {
		// that = this;
		// var doc = CodeKindaSmart.documents.getOrFetch(id,
		// 	function (doc) {
		// 		var view = new CodeKindaSmart.Views.DocumentsShow({
		// 			model: doc,
		// 			annotation_id: id
		// 		});
		// 		that._swapView(view)
		// 	}
		// );
		// var annotation = CodeKindaSmart.doc.annotations.getOrFetch(id,
		// 	function (annotation) {
		// 		var view = new CodeKindaSmart.Views.AnnotationsShow({
		// 			annotation: annotation
		// 		});
		// 		that._swapView(view)
		// 	}
		// );
	},

	showDocument: function(id) {
		that = this;
		var doc = CodeKindaSmart.documents.getOrFetch(id,
			function (doc) {
				CodeKindaSmart.doc = doc
				var view = new CodeKindaSmart.Views.DocumentsShow({
					model: doc
				});
				that._swapView(view)
			}
		);
	},

	showHomepage: function () {
		var view = new CodeKindaSmart.Views.StaticHomepage()
		this._swapView(view)
	},

	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  $("#content").html(newView.render().$el);
	  // this.$rootEl.html(newView.render().$el);
	}
});