module Api
	class ApiController < ApplicationController
		skip_before_action with: :null_session
	end
end