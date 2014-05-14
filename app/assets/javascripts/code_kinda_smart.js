window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.documents = new CodeKindaSmart.Collections.Documents();
    CodeKindaSmart.router = new CodeKindaSmart.Router({
      $rootEl: $('#content')
    });
    Backbone.history.start()
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})