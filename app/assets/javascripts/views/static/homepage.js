CodeKindaSmart.Views.StaticHomepage = Backbone.View.extend({

	template: JST['static/homepage'],

	initialize: function () {
		var xhReq = new XMLHttpRequest();
		xhReq.open("GET", "/api/homepage", false);
		xhReq.send(null);
		this.ranking = JSON.parse(xhReq.responseText);
		console.log(this.ranking)
	},

	render: function () {
		var content = this.template ({
			ranking: this.ranking
		});
		this.$el.html(content);
		return this;
	}

});