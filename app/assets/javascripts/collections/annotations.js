CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(models, options) {
  },

  setDocument: function(doc) {
    this.document = options.doc;
  }

  url: function () {
    return "api/documents/" + this.document.id + "/annotations"
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