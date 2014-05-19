window.CodeKindaSmart = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    if(localStorage.getItem('popUps') === null) {
      CodeKindaSmart.popUps = {homepage: true, doc: true}
      CodeKindaSmart.popUps
      localStorage.setItem('popUps', JSON.stringify(CodeKindaSmart.popUps))
    } else {
      CodeKindaSmart.popUps = JSON.parse(localStorage.getItem('popUps'))
    }

    if(CodeKindaSmart.currentUser.username && CodeKindaSmart.currentUser.username != 'Guest'){
      CodeKindaSmart.popUps = {homepage: false, doc: false}
      localStorage.setItem('popUps', JSON.stringify(CodeKindaSmart.popUps))
    }

    CodeKindaSmart.documents = new CodeKindaSmart.Collections.Documents();
    
    CodeKindaSmart.appRouter = new CodeKindaSmart.Routers.AppRouter({
      $rootEl: $('#content')
    });


    Backbone.history.start();
  }
};

$(document).ready(function () {
  CodeKindaSmart.initialize();
})