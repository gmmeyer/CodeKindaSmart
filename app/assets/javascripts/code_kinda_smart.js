window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.router = new CodeKindaSmart.Router({
      $rootEl: $('#body')
    });
    Backbone.history.start()
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})