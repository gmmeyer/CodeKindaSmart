class NotificationsController < ApplicationController

	def show
		notification = current_user.notiications.find(params[:id])
		notifications.update(is_read: true)
		redirect_to notification.url
	end
end