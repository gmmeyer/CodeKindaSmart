window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.documents = new CodeKindaSmart.Collections.Documents();
    CodeKindaSmart.router = new CodeKindaSmart.Router({
      $rootEl: $('#body')
    });
    Backbone.history.start()
  }
};

// $(document).ready(function () {
//   CodeKindaSmart.initialize();
// })