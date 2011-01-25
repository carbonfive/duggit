class HomeController < ApplicationController

  def index
    @links = Link.order('created_at DESC').limit(30)
    @votes = Vote.where(:link_id => @links, :user_id => current_user).each_with_object({}) do |vote, map|
      map[vote.link_id] = vote
    end
  end

end
