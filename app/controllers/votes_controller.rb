class VotesController < ApplicationController

  before_filter :require_authentication
  before_filter :validate_ownership

  def create
    vote = Vote.new params[:vote].merge(:user => current_user, :link_id => params[:link_id])
    unless vote.save
      flash[:error] = "Unable to tally your vote"
    end

    redirect_to root_path
  end

  def update
    vote = Vote.find params[:id]
    vote.update_attributes params[:vote]
    unless vote.save
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

  def validate_ownership
    link = Link.where(:id => params[:link_id]).first
    if link.author == current_user
      flash[:error] = "You cannot vote for your own links"
      redirect_to root_path
    end
  end

end