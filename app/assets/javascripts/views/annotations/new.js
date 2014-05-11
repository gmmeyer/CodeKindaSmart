CodeKindaSmart.Views.AnnotationsNew = Backbone.View.extend({

	template: JST['annotations/show'],

	initialize: function () {
		
	},

	events: {
		"click .submit-annotation" : "submitAnnotation"
	}

})