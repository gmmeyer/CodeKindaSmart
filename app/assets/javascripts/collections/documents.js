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
        model._annotations = new CodeKindaSmart.Collections.Annotations([],{doc: model})
        model._annotations.fetch()
        callback(model);
      }
    });
   } else {
    callback(model);
   }
   return model;
	}

});
