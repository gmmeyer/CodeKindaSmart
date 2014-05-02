CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	urlRoot: function () {
		return "api/annotations/" + this.id
		}

});