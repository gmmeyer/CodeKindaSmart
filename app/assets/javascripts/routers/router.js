CodeKindaSmart.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

	routes: {
		'/annotations/:id' : 'showAnnotations',
		'/documents/:id/annotations' : 'annotationIndex',
		'/documents/:id' : 'showDocument',
		'' : 'staticHomepage'
	},

	annotationIndex: function () {
		var view = new CodeKindaSmart.Views.AnnotationsIndex({
			collection: CodeKindaSmart.annotations
		});
		this._swapView(view);
	},

	showAnnotations: function () {
	},

	showDocument: function(id) {
		var doc = CodeKindaSmart.documents.getOrFetch(id);
		var view = new CodeKindaSmart.Views.DocumentsShow({
			doc: doc
		})
		this._swapView(view)
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