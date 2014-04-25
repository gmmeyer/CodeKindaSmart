class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:settings]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      flash[:notices] = ["Welcome to Rap Kinda Smart #{@user.username}, and congratulations on your new account!"]
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def destroy
    @user = current_user
    @user.destroy
  end

  def settings
    @user = current_user
  end

  def update
    @user = current_user
    # unfinished.
    raise "DO NOT USE THIS IS NOT FINISHED"
  end

  private
  def user_params
    params.require(:user).permit(:username,:password,:password_confirmation,:email)
  end
end
