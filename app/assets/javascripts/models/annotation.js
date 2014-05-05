CodeKindaSmart.Models.Annotation = Backbone.Model.extend({

	urlRoot: function () {
		return "/api/annotations/" + this.id
	},

  document: function() {
    if(!this._document) {
      this._document = new CodeKindaSmart.Models.Document([], {
        _document: this
      });
	  };

	  return this._document;
  }

});