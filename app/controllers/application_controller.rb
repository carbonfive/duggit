class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user, :logged_in?

 private

  def current_user
    @_current_user ||= current_user_session.user
  end

  def logged_in?
    current_user_session.present?
  end

  def current_user_session
    @_current_user_session ||= UserSession.find
  end

  def authenticate
    unless logged_in?
      redirect_to new_user_session_path
    end
  end

end
