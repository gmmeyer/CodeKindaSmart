CodeKindaSmart.Views.AnnotationsNew = Backbone.View.extend({

	template: JST['annotations/new'],

	initialize: function (options) {
		this.annotation = new CodeKindaSmart.Models.Annotation()
		this.annotation.attributes.range = options.range;
		this.annotation.attributes.start_location = options.start_location;
		this.annotation.attributes.end_location = options.end_location;
	},

	render: function () {
		var content = this.template({
			annotation: this.annotation
		});
		this.$el.html(content)
		return this;
	},

	events: {
		"click .submit-annotation" : "submitAnnotation"
	}

})