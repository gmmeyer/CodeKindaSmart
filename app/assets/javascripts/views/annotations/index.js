CodeKindaSmart.Views.AnnotationsIndex = Backbone.View.extend({

  initialize: function () {
    // $(".annotation-highlight").click(function (event) {
    //   event.preventDefault();
    // })
  },

  template: JST['annotations/index'],

  events: { 
  	"click .annotation-highlight .annotation-link" : "showAnnotation"
  },

  render: function () {
	  var content = this.template({
	    annotations: this.annotations
	  });

	  this.$el.html(content);
	  return this;
  },


  showAnnotation: function (event) {
    event.preventDefault();
    console.log(event)
    var view = new CodeKindaSmart.Views.AnnotationsShow({
      annotations: this.collection
    });
    // $(event.currentTarget).replaceWith(view.render().$el);
  }
  

});
