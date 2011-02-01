class VotesController < ApplicationController

  before_filter :require_authentication

  def create
    link = Link.find params[:link_id]
    vote = link.votes.find_or_create_by_user_id current_user.id 
    unless vote.update_attributes params[:vote]
      flash[:alert] = "Unable to tally your vote"
    end
    redirect_to root_path
  end

end
