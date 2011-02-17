class LinksController < ApplicationController

  before_filter :require_authentication,
    :only => [:new, :create]

  def new
    @link = Link.new
  end

  def create
    link = Link.new({ :user_id => current_user.id }.merge(params[:link]))
    link.save
    flash[:notice] = 'Thanks for your link!'
    redirect_to root_path
  end

  def index
    @links = Link.recent :limit => 30
  end

end
