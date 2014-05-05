CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(options) {
  },

  url: function () {
    return "/api/documents/" + this._document.id + "/annotations"
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