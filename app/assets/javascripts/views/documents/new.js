CodeKindaSmart.Views.DocumentsNew = Backbone.View.extend({
	template: JST['documents/form'],

	initialize: function () {
	},

	events: {
		'click .submit' : 'submit'
	},

	
})