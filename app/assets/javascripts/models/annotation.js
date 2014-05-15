CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	initialize: function (models, options) {
		if(options && options.id){
			this.id = options.id
		}
	},

	urlRoot: function () {
		if(this.id){
			return "/api/annotations/" + this.id
		} else {
			return "/api/annotations"
		}
	}

});