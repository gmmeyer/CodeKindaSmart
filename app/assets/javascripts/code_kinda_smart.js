window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.annotations = new CodeKindaSmart.Collections.Annotations();
    CodeKindaSmart.router = new CodeKindaSmart.Router({
      $rootEl: $('#content')
    });
    // if (!History.started){
      // Backbone.history.start();
    // }
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})