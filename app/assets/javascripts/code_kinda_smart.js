window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.documents = new CodeKindaSmart.Collections.Documents();
    
    CodeKindaSmart.appRouter = new CodeKindaSmart.Routers.AppRouter({
      $rootEl: $('#content')
    });

    CodeKindaSmart.popUps = {homepage: false, document: false}

    Backbone.history.start();
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})