CodeKindaSmart.Views.AnnotationsForm = Backbone.View.extend({

	className: "form-annotation-wrapper group",

	template: JST['annotations/form'],

	initialize: function (options) {
		this.annotation = new CodeKindaSmart.Models.Annotation()
		this.start_location = options.start_location;
		this.end_location = options.end_location;

		this.listenTo(CodeKindaSmart.doc, 'sync', this.remove());

		this.annotation.collection = CodeKindaSmart.doc.annotations;
	},

	render: function () {
		var content = this.template({
			annotation: this.annotation,
			start_location: this.start_location,
			end_location: this.end_location
		});
		this.$el.html(content)
		return this;
	},

	events: {
		"click .submit-annotation" : "submitAnnotation"
	},


  submitAnnotation: function (event) {
    var that = this;
    event.preventDefault();
    var attrs = this.$("form.new-annotation").serializeJSON();
    this.annotation.save(attrs, {
      success: function (post) {
        that.annotation.collection.add(post);
        CodeKindaSmart.doc.fetch()
      }
    });
  }

});