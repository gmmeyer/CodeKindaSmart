class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(token: session[:token])
  end

  def login!(user)
    user.reset_token!
    @current_user = user
    session[:token] = user.token
  end

  def logout!
    current_user.reset_token!
    session[:token] = nil
  end

  def require_current_user!
    redirect_to new_user_url unless current_user
  end

  def require_no_current_user!
    redirect_to root_url if current_user
  end
end