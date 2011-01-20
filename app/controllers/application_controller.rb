class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    return @current_user if defined?(@current_user)
    session = UserSession.find
    @current_user = session && session.user
  end
end
