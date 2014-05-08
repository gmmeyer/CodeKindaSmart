CodeKindaSmart.Views.AnnotationsIndex = Backbone.View.extend({

  initialize: function () {
  },

  template: JST['annotations/index'],
  className: "activeAnnotations",

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
  }
  

});
