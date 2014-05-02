CodeKindaSmart.Models.Document = Backbone.Model.extend({
	urlRoot: function () {
		"api/documents/" + this.id
	},

 annotations: function () {
  if(!this._annotations) {
    this._annotations = new CodeKindaSmart.Models.Annotations([], { document: this });
  }
  return this._lists;
 },



});
