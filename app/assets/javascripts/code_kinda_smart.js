window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.router = new CodeKindaSmart.Routers.Segments({
      $rootEl: $('.bookmark')
    });
    // Backbone.history.start();
  }
};

$(document).ready(function(){
  CodeKindaSmart.initialize();
});