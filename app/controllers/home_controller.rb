class HomeController < ApplicationController

  def index
    @links = Link.order('created_at DESC').limit(30)
  end

end
