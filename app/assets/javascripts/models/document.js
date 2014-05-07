CodeKindaSmart.Models.Document = Backbone.Model.extend({

	initialize: function (models, options) {
		this.id = options.id;
	},


	url: function () {
		return "/api/documents/" + this.id
	},

 annotations: function () {
  if(!this.annotations && this.attributes.annotations) {
    this.annotations = new CodeKindaSmart.Collections.Annotations([], { 
    	_document: this,
    	annotations: this.attributes.annotations
    });
  }

  // return this._annotations;
 }



});
