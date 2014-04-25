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
      flash[:notices] = ["Welcome to Rap Kinda Smart, #{@user.username}!"]
      redirect_to root_url
    else
      flash.now[:errors] = ['Invalid username or password.']
      @user = User.new
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
