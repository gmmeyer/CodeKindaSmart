CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(models, options) {
    this._document = options.doc
  },

  url: function () {
    return "/api/documents/" + this._document.id + "/annotations"
  },

	getOrFetch: function (callback) {
    var that = this
    var model = this.get(id);
    if(!model) {
      model = new CodeKindaSmart.Models.Annotation({ id: id });
      model.collection = this;
      model.fetch({
        success: function() {
          that.add(model)
          callback(model)
        }
      });
    } else {
      callback(model)
    }

    return model;
	}

});