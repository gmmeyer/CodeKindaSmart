CodeKindaSmart.Views.StaticHomepage = Backbone.View.extend({

	template: JST['static/homepage'],

	render: function () {
		var content = this.template ();
		this.$el.html(content);
		return this
	}

})