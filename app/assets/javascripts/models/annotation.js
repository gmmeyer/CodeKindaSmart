CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	initialize: function (models, options) {
	},

	urlRoot: function () {
		console.log(this)
		return "/api/annotations/" + this.id
	}

});