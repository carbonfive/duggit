class VotesController < ApplicationController

  before_filter :require_authentication

  def create
    link = Link.find params[:link_id]
    vote = link.votes.new params[:vote]
    vote.user = current_user
    unless vote.save
      flash[:error] = "Unable to tally your vote"
    end

    redirect_to root_path
  end

  def update
    link = Link.find params[:link_id]
    vote = link.votes.find params[:id]
    unless vote.update_attributes params[:vote]
      flash[:error] = "Unable to tally your vote"
    end

    redirect_to root_path
  end

  private

  def require_authentication
    unless logged_in?
      flash[:message] = "You must be logged in"
      redirect_to root_path
    end
  end

end