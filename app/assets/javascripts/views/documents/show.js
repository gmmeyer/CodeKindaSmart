CodeKindaSmart.Views.DocumentsShow = Backbone.View.extend({

  template: JST['documents/show'],


  render: function () {
  	var content = this.template({
  		doc: this.doc
  	});
  	this.$el.html(content);
  	return this;
  }
  

});
