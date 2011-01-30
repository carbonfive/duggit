class LinksController < ApplicationController

  before_filter :authenticate,
    :only => [:new, :create]

  def new
    @link = Link.new
  end

  def create
    link = current_user.links.new params[:link]
    link.save
    flash[:notice] = 'Thanks for your link!'
    redirect_to root_path
  end

  def index
    @links = Link.recent :limit => 30
  end

end
