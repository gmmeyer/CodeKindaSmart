CodeKindaSmart.AppRouter = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl
  },

	routes: {
		'documents/new' : 'newDocument',
		'documents/:id/edit' : 'editDocument',
		'documents/:id' : 'showDocument',
		'' : 'showHomepage'
	},

	newDocument: function (id) {
		var view = new CodeKindaSmart.Views.DocumentsNew()
		this._swapView(view)
	},

	editDocument: function (id) {
		var that = this;
		var doc = CodeKindaSmart.documents.getOrFetch(id,
			function (doc) {
				CodeKindaSmart.doc = doc
				var view = new CodeKindaSmart.Views.DocumentsEdit({
					model: doc
				});
				that._swapView(view)
			}
		);
	},

	showDocument: function(id) {
		var that = this;
		var doc = CodeKindaSmart.documents.getOrFetch(id,
			function (doc) {
				CodeKindaSmart.doc = doc;
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
	  this.$rootEl.html(newView.render().$el);
	}
});