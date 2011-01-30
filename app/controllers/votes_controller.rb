class VotesController < ApplicationController

  before_filter :authenticate

  def create
    link = Link.find params[:link_id]
    vote = link.votes.new params[:vote]
    vote.user = current_user
    unless vote.save
      flash[:alert] = "Unable to tally your vote"
    end
    redirect_to root_path
  end

end
