CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	initialize: function (models, options) {
		if(options && options.id){
			this.id = options.id
		}
	},

	// url: "/api/annotations",

	// urlRoot: function () {
	// 	console.log('oh hai');
	// 	if(this.id){
	// 		return "/api/annotations/" + this.id
	// 	} else {
	// 		return "/api/annotations/"
	// 	}
	// }

});