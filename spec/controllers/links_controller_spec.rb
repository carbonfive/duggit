require 'spec_helper'

describe LinksController do

  describe '#new' do
    context 'when logged in' do
      before do
        user = Factory :user
        login user

        get :new
        @link = assigns :link
      end

      it 'creates a new link' do
        @link.should be
        @link.value.should == 0
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
    context 'when logged in' do
      before do
        user = Factory :user
        login user

        post :create, 
          :link => { :title => 'Carbon Five', :url => 'http://www.carbonfive.com' }

        @link = Link.recent(:limit => 1)[0]
      end

      it 'creates a new link' do
        @link.should be
        @link.title.should == 'Carbon Five'
        @link.url.should == 'http://www.carbonfive.com'
      end

      it 'sets a flash message' do
        flash[:notice].should be
      end

      it 'redirects to the homepage' do
        response.should redirect_to root_path
      end
    end

    context 'when not logged in' do
      before do
        post :create
      end

      it 'redirects to the login page' do
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe '#index' do
    before do
      user = Factory :user

      5.times do |i|
        link = Link.new :user_id => user.id, :title => "#{i}", :url => "http://foo.com/#{i}"
        link.save!
      end

      get :index

      @links = assigns :links
    end

    it 'finds recent links' do
      @links.should be
      @links.should have(5).links
    end

    it 'displays the homepage' do
      response.should render_template :index
    end
  end

end
