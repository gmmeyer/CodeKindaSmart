CodeKindaSmart.Collections.Documents = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Document,
  url: "/api/documents",
  
 	getOrFetch: function (id, callback) {
    var that = this;
   var model = this.get(id);
   if(!model) {
     model = new CodeKindaSmart.Models.Document([], { id: id });
     model.collection = this.docs;
     model.fetch({
      success: function () {
        that.add(model);
        model.annotations = new CodeKindaSmart.Collections.Annotations([model.attributes.annotations],{doc: model})
        model.segments = new CodeKindaSmart.Collections.Segments(model.segments, {doc: model})
        model.annotations.fetch()
        model.segments.fetch()
        callback(model);
      }
    });
   } else {
    callback(model);
   }
   return model;
	}

});
