CodeKindaSmart.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

	routes: {
		'annotations/:id': 'showAnnotations',
	},

	annotationIndex: function () {
		var view = new CodeKindaSmart.Views.AnnotationsIndex({
			collection: CodeKindaSmart.annotations
		});
		this._swapView(view);
	},

	showAnnotations: function (id) {
		that = this;
		var annotation = CodeKindaSmart.doc.annotations.getOrFetch(id,
			function (annotation) {
				var view = new CodeKindaSmart.Views.AnnotationsShow({
					annotation: annotation
				});
				that._swapView(view)
			}
		);
	},

	showDocument: function(id) {
		that = this;
		var doc = CodeKindaSmart.documents.getOrFetch(id,
			function (doc) {
				var view = new CodeKindaSmart.Views.DocumentsShow({
					model: doc
				});
				that._swapView(view)
			}
		);
	},

	staticHomepage: function () {
		var view = new CodeKindaSmart.Views.StaticHomepage()
		this._swapView(view)
	},

	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  this.$rootEl.html(newView.render().$el);
	}
});