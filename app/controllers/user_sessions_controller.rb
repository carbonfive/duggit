class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new params[:user_session]
    @user_session.save
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
  
end