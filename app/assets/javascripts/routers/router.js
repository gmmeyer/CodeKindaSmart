CodeKindaSmart.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

	routes: {
		"annotations/:ids" : "showAnnotations",
		"documents/:id/annotations" : "annotationIndex",
		"documents/:id" : "annotationIndex",
		"" : "staticHomepage"
	},

	annotationIndex: function () {
		event.preventDefault();
		var view = new CodeKindaSmart.Views.AnnotationsIndex({
			collection: CodeKindaSmart.annotations
		});
		this._swapView(view);
	},

	showAnnotations: function () {
	},

	showDocument: function() {
		var view = new CodeKindaSmart.Views.DocumentsShow({
			model: CodeKindaSmart
		})
	},

	staticHomepage: function () {
				
	},



	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  this.$rootEl.html(newView.render().$el);
	}
});