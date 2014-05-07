CodeKindaSmart.Models.Document = Backbone.Model.extend({

	initialize: function (models, options) {
		this.id = options.id;
	},


	url: function () {
		return "/api/documents/" + this.id
	},

 annotations: function () {
  if(!this._annotations && this.attributes.annotations) {
    this._annotations = new CodeKindaSmart.Collections.Annotations([], { 
    	_document: this,
    	annotations: this.attributes.annotations
    });
  }

  // return this._annotations;
 }



});
