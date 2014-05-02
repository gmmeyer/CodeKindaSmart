CodeKindaSmart.Routers.Annotations = Backbone.Router.extend({

	routes: {
		"annotations/:ids" : "showAnnotations",
		"annotations" : "annotationIndex",
		""
	},

	showAnnotations: function (ids) {
		var annotations = []
		for(var i = 0, i < ids.length, i++)
			var board = 
		
	}

	  boardShow: function (id) {
    var board = Trellino.boards.getOrFetch(id);

    var view = new Trellino.Views.BoardShow({
      model: board
    });

    this._swapView(view);
  },


	_swapView: function (newView) {
	  this._currentView && this._currentView.remove();
	  this._currentView = newView;
	  this.$rootEl.html(newView.render().$el);
	}
});