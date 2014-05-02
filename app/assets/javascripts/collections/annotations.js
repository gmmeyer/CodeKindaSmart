CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(models, options) {
    this.document = options.document;
  },

  url: function () {
    return "api/annotations" + this.document.id + 
  },

	getOrFetch: function (id) {
    var model = this.get(id);
    if(!model) {
      model = new CodeKindaSmart.Models.Annotation({ id: id });
      model.collection = this;
    }
    model.fetch(); // fetch anyways
    return model;
	}

});
