class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
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

  private
  def user_params
    params.require(:user).permit(:username,:password,:password_confirmation,:email)
  end
end
