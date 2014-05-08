CodeKindaSmart.Models.Document = Backbone.Model.extend({

	initialize: function (models, options) {
		this.id = options.id;
	},


	url: function () {
		return "/api/documents/" + this.id
	}



});
