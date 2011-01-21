class LinksController < ApplicationController

  def new
    redirect_to new_user_session_path unless logged_in?
    @link = Link.new
  end

  def create
    @link = Link.new params[:link]
    @link.save
    flash[:message] = 'Thanks for your link!'
    redirect_to root_path
  end

end