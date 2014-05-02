window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    CodeKindaSmart.router = new CodeKindaSmart.Routers.Annotations({
      $rootEl: $('.bookmark')
    });
    Backbone.history.start();
  }
};