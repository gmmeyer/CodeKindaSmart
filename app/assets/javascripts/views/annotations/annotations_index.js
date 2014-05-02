CodeKindaSmart.Views.AnnotationsIndex = Backbone.View.extend({

  template: JST['annotations/index'],

  events: { 
  	"click annotation-link" : "showAnnotation"
  },

  render: function () {
	  var content = this.template({
	    boards: this.collection
	  });

	  this.$el.html(content);
	  return this;
  },


  showAnnotation: function (event) {
    event.preventDefault();
    var view = new CodeKindaSmart.Views.AnnotationsShow({
      annotations: this.model
    });
    $(event.currentTarget).replaceWith(view.render().$el);

  }
  

});
