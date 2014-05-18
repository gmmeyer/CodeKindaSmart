CodeKindaSmart.Views.StaticHomepage = Backbone.View.extend({

	template: JST['static/homepage'],

	initialize: function () {
		var xhReq = new XMLHttpRequest();
		xhReq.open("GET", "/api/homepage", false);
		xhReq.send(null);
		this.ranking = JSON.parse(xhReq.responseText);
		console.log(this.ranking)
	},

	events: {
    "click .tour-wrapper" : 'hideTour',
    "click .tour-button-ok" : 'hideTour',
    "click .close-tour" : 'hideTour',
    "click .tour-button-next" : "nextTour",
    "click .tour-button-back" : "backTour",
    "click .tour-button-beginning" : "firstTour"//,
    // "click .tour-button-login" : 'loginGuest'
	},

	render: function () {
		var content = this.template ({
			ranking: this.ranking
		});
		this.$el.html(content);
		return this;
	},

	hideTour: function () {
		$(".tour-wrapper").addClass('isHidden')
	},

	nextTour: function () {
		currentSlide = $('.currentSlide')
	},

	firstTour: function () {
		$('.currentSlide').addClass('isHidden')
		$('.currentSlide').removeClass('currentSlide')
		$('.tour ul li').first().addClass('currentSlide')
	}

});