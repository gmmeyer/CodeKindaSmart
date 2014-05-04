CodeKindaSmart.Models.Document = Backbone.Model.extend({

	initialize: function (models, options) {
		this = options.doc
		// this.id = options.doc.id
		// this.title = options.doc.title
		// this.body = options.doc.body
		// this.author_id = options.doc.author_id
		// this.release_date = options.doc.release_date
		// this.summary = options.doc.summary
	},


	urlRoot: function () {
		"api/documents/" + this.id
	},

 annotations: function () {
  if(!this._annotations) {
    this._annotations = new CodeKindaSmart.Collections.Annotations([], { 
    	_document: this
    });
  }

  return this._annotations;
 },



});
