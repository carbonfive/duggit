class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    return @current_user if @current_user
    user_session = UserSession.find
    @current_user = user_session && user_session.user
  end

  def logged_in?
    current_user.present?
  end
end
