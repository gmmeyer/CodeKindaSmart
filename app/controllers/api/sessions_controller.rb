module Api
	class SessionsController < ApiController
	  before_filter :require_current_user!, only: [:destroy]
	  before_filter :require_no_current_user!, only: [:new, :create]
	  
		def new
		end

	end
end