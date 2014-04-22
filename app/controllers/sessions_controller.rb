class SessionsController < ApplicationController
  before_filter :require_current_user!, only: [:destroy]
  before_filter :require_no_current_user!, only: [:new, :create]

  def new
    @user = User.new()
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login!(@user)
      redirect_to root_url
    else
      flash[:errors] = ['Invalid username or password.']
      @user = User.new
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def require_current_user!
    redirect_to new_user_url unless current_user
  end

  def require_no_current_user!
    redirect_to root_url if current_user
  end

end
