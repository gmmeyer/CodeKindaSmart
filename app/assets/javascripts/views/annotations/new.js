CodeKindaSmart.Views.AnnotationsNew = Backbone.View.extend({

	className: "new-annotation-wrapper"

	template: JST['annotations/new'],

	initialize: function (options) {
		this.annotation = new CodeKindaSmart.Models.Annotation()
		// this.annotation.attributes.range = options.range;
		// this.annotation.attributes.start_location = options.start_location;
		// this.annotation.attributes.end_location = options.end_location;
		// this.range = options.range;
		this.start_location = options.start_location;
		this.end_location = options.end_location;

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
    console.log(event)
    console.log(attrs)
    // console.log($("form.new-annotation"))
    // this.annotation.attributes.document_id = attrs.annotation.document_id
    // this.annotation.attributes.user_id = attrs.annotation.user_id
    // this.annotation.attributes.body = attrs.annotation.body
    // this.annotation.attributes.title = attrs.annotation.title
    this.annotation.save(attrs, {
      success: function (post) {
        that.annotation.collection.add(post);
        Backbone.history.navigate("", { trigger: true });
      }
    });
  }

})