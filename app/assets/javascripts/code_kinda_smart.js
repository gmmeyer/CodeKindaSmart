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
    Backbone.history.start()
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})