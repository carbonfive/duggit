require 'spec_helper'

describe LinksController do

  describe '#new' do
    context 'when logged in' do
      before do
        @link = stub 'link'

        Link.
          stubs(:new).
          with().
          returns(@link)

        user = Factory :user
        login user

        get :new
      end

      it 'creates a new link' do
        Link.should have_received(:new).with()
        assigns(:link).should == @link
      end

      it 'displays the new link page' do
        response.should render_template :new
      end
    end

    context 'when not logged in' do
      before do
        get :new
      end

      it 'redirects to the login page' do
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe '#create' do
    before do
      @params = {}
      @link = stub 'link'
      @link.
        stubs(:save).
        with()

      Link.
        stubs(:new).
        with(@params).
        returns(@link)

      user = Factory :user
      login user

      post :create, 
        :link => @params
    end

    it 'creates a new link' do
      Link.should have_received(:new).with(@params)
      @link.should have_received(:save).with()
    end

    it 'sets a flash message' do
      flash[:notice].should be
    end
    
    it 'redirects to the homepage' do
      response.should redirect_to root_path
    end
  end

  describe '#index' do
    before do
      @links = stub 'recent links'
      @limit = 30
      Link.
        stubs(:recent).
        with(:limit => @limit).
        returns(@links)

      get :index
    end

    it 'finds recent links' do
      Link.should have_received(:recent).with(:limit => @limit)
      assigns(:links).should == @links
    end

    it 'renders the homepage' do
      response.should render_template :index
    end

    it 'is routed to from "/"' do
      { :get => '/' }.should route_to(:controller => 'links',
                                      :action => 'index')
    end
  end

end
