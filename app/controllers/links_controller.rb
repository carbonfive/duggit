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

  def index
    @links = Link.order('created_at DESC').limit(30)
    @votes = Vote.where(:link_id => @links, :user_id => current_user).each_with_object({}) do |vote, map|
      map[vote.link_id] = vote
    end
  end

end
