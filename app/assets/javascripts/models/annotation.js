CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	initialize: function (models, options) {

		// this.id = options.id
			
	},

	urlRoot: function () {
		// return "/api/annotations/" + this.id
		return "/api/annotations/"
	}

});