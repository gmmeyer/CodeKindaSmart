CodeKindaSmart.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

	routes: {
		"annotations/:ids" : "showAnnotations",
		"annotations" : "annotationIndex",
		"" : "annotationIndex"
	},

	annotationIndex: function () {
		var view = new CodeKindaSmart.Views.AnnotationsIndex({
			collection: CodeKindaSmart.annotations
		});
		this._swapView(view);
	},


	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  this.$rootEl.html(newView.render().$el);
	}
});