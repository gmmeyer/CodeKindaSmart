CodeKindaSmart.Routers.TourRouter = Backbone.Router.extend({

	initialize: function (options) {
		this.$rootEl = options.$rootEl
	},

	routes: {
		'documents/:id': 'documentTour',
		'': 'welcomeTour'
	},

	welcomeTour: function () {

	},

	documentsTour: function () {

	},

	_swapView: function (newView) {
		this._currentView && this.currentView.remove()
		this._currentView = newView;
		this.$rootEl.html(newView.render().el) 
	}



})