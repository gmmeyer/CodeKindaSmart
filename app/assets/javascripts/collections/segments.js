CodeKindaSmart.Collections.Segments = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Segment,
  initialize: function (models, options) {
  	this.doc = options.doc
  },
  
  url: function() {
  	return "/api/documents/" + this.doc.id + "/segments"
  }

});