CodeKindaSmart.Views.StaticHomepage = Backbone.View.extend({

	template: JST['static/homepage'],

	initialize: function () {
		var xhReq = new XMLHttpRequest();
		xhReq.open("GET", "/api/homepage", false);
		xhReq.send();
		this.ranking = JSON.parse(xhReq.responseText);
	},

	events: {
    "click .tour-wrapper" : 'hideTour',
    "click .tour-button-ok input" : 'hideTour',
    "click .close-tour" : 'hideTour',
    "click .tour-button-next input" : "nextTour",
    "click .tour-button-back input" : "backTour",
    "click .guest-login" : "login",
    "click .home" : "home",
	},

	home: function (event) {
		event.preventDefault()
		CodeKindaSmart.appRouter.navigate("", {trigger: true})
	},

	render: function () {
		var content = this.template ({
			ranking: this.ranking
		});
		this.$el.html(content);
		return this;
	},

	hideTour: function (event) {
		event.preventDefault()
		$('.tour').addClass('isHidden')
		$(".tour-wrapper").addClass('isHidden')
	},

	login: function (event) {
		$('.tour').addClass('isHidden')
		$('.tour-wrapper').addClass('isHidden')
		CodeKindaSmart.currentUser.username = 'Guest'
	},

	backTour: function (event) {
		event.preventDefault()
		currentSlide = $('.currentSlide')
		prevSlide = currentSlide.prev();
		if(!!prevSlide[0]){
			currentSlide.removeClass('currentSlide')
			prevSlide.addClass('currentSlide')
			$('.tour-button-back').addClass('button-disabled')
			$('.tour-button-next').removeClass('button-disabled')			
		}
	},

	nextTour: function (event) {
		event.preventDefault()
		currentSlide = $('.currentSlide')
		nextSlide = currentSlide.next();
		if(!!nextSlide[0]){
			currentSlide.removeClass('currentSlide')
			nextSlide.addClass('currentSlide')
			$('.tour-button-next').addClass('button-disabled')
			$('.tour-button-back').removeClass('button-disabled')			
		}
	},

	firstTour: function () {
		event.preventDefault()
		$('.currentSlide').addClass('isHidden')
		$('.currentSlide').removeClass('currentSlide')
		$('.tour ul li').first().addClass('currentSlide')
	}

});