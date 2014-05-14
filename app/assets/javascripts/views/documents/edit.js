CodeKindaSmart.Views.DocumentsEdit = Backbone.View.extend({
	template: JST['documents/form'],
	
	initialize: function(options){
		this.doc = options.doc
	},

	events: {
		"click .submit" : "submit"
	},

	
})