class VotesController < ApplicationController

  before_filter :require_authentication

  def create
    vote = Vote.new :user_id => current_user.id,
                    :link_id => params[:link_id].to_i,
                    :value => params[:vote][:value].to_i

    unless vote.save
      flash[:alert] = "Unable to tally your vote"
    end

    redirect_to root_path
  end

end
