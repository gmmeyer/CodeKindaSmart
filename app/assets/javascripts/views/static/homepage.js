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
    "click .tour-button-ok input" : 'hideTour',
    "click .close-tour" : 'hideTour',
    "click .tour-button-next input" : "nextTour",
    "click .tour-button-back input" : "backTour"
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
		console.log(event)
		$('.tour').addClass('isHidden')
		$(".tour-wrapper").addClass('isHidden')
	},

	backTour: function (event) {
		event.preventDefault()
		console.log(event)
		currentSlide = $('.currentSlide')
		prevSlide = currentSlide.prev();
		currentSlide.removeClass('currentSlide')
		prevSlide.addClass('currentSlide')
	},

	nextTour: function (event) {
		event.preventDefault()
		console.log(event)
		currentSlide = $('.currentSlide')
		nextSlide = currentSlide.next();
		currentSlide.removeClass('currentSlide')
		nextSlide.addClass('currentSlide')
		if(!nextSlide.next()){
			$('.tour-button-next').addClass('isHidden')
		}
	},

	firstTour: function () {
		event.preventDefault()
		$('.currentSlide').addClass('isHidden')
		$('.currentSlide').removeClass('currentSlide')
		$('.tour ul li').first().addClass('currentSlide')
	}

});