CodeKindaSmart.Collections.Annotations = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Annotation,

  initialize: function(models, options) {
    this.document = options.doc
  },

  url: function () {
    return "/api/documents/" + this.document.id + "/annotations"
  },

	getOrFetch: function (ids, callback) {
    console.log(ids)
    console.log(ids.length);
    var that = this
    var models = []

    for(var i = 0; i < ids.length; i++) {
      var model = this.get(ids[i]);
      if(!model) {
        model = new CodeKindaSmart.Models.Annotation({ id: ids[i] });
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
      models.push(model)
    }

    // if(models[1] === 'undefined'){
    //   return models[0];
    // } else {
    //   return models;
    // }
    return models;
	}

});