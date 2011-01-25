require 'spec_helper'

describe LinksController do

  describe '#new' do
    context 'given the current user is logged in' do
      before do
        user = Factory :user
        login user
        get :new
      end

      it 'displays a new link form' do
        response.should render_template(:new)
      end

      it 'creates an empty link object' do
        assigns(:link).should be
      end
    end

    context 'given there is no current user' do
      before do
        get :new
      end

      it 'redirects the user to the login page' do
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    before do
      @user = Factory :user
      login @user
      @count = Link.count
      post :create, :link => { :title => 'title', :url => 'http://example.com' }
      @link = Link.find assigns(:link).id
    end

    it 'saves the link' do
      Link.count.should be(@count + 1)
    end
    
    it 'save the link properties' do
      @link.title.should == 'title'
      @link.url.should == 'http://example.com'
    end

    it 'belongs to the logged in user' do
      @link.author.should == @user
    end

    it 'redirects me to the home page' do
      response.should redirect_to(root_path)
    end
  end
end