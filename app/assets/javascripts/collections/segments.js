CodeKindaSmart.Collections.Segments = Backbone.Collection.extend({

  model: CodeKindaSmart.Models.Segment,
  initialize: function (models, document) {
  	this._document = options.document
  },
  
  url: function() {
  	return "/api/documents/" + this.document.id + "/segments"
  }

});