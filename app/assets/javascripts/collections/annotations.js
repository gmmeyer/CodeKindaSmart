CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(models, options) {
    this.doc = options.doc
    this.document_id = this.doc.id
  },

  url: function () {
    return "api/documents/" + this.document_id + "/annotations"
  },

	getOrFetch: function (ids, callback) {
    var that = this
    var models = []

    for(var i = 0; i < ids.length; i++) {
      var model = this.get(ids[i]);
      if(!model) {
        model = new CodeKindaSmart.Models.Annotation([], { id: ids[i] });
        model.collection = this;
        model.fetch({
          success: function() {
            that.add(model)
            if(callback){
              callback(model)
            }
          }
        });
      } else {
        if(callback){
          callback(model)
        }
      }
      models.push(model)
    }
    return models;
	}

});