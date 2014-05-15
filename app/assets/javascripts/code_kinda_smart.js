window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.documents = new CodeKindaSmart.Collections.Documents();
    CodeKindaSmart.appRouter = new CodeKindaSmart.AppRouter({
      $rootEl: $('#content')
    });
    Backbone.history.start()
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})