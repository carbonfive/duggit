class LinksController < ApplicationController

  def new
    return redirect_to new_user_session_path unless logged_in?

    @link = Link.new
  end

  def create
    return redirect_to new_user_session_path unless logged_in?

    @link = Link.new params[:link].merge(:author => current_user)
    @link.save
    flash[:message] = 'Thanks for your link!'
    redirect_to root_path
  end

end