CodeKindaSmart.Collections.Documents = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Document,
  url: "api/documents/",
  
 	getOrFetch: function (id) {
   var model = this.get(id);
   if(!model) {
     model = new CodeKindaSmart.Models.Documents({ id: id });
     model.collection = this;
   }
   model.fetch(); // fetch anyways

   return model;
	}

});
