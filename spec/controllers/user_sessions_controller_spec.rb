require 'spec_helper'

describe UserSessionsController do

  describe '#new' do
    before do
      @user_session = stub 'user session'
      UserSession.
        stubs(:new).
        with().
        returns(@user_session)

      get :new
    end

    it 'initializes a new user session' do
      UserSession.should have_received(:new).with()
      assigns(:user_session).should == @user_session
    end

    it 'displays the login page' do
      response.should render_template :new
    end
  end

  describe '#create' do
    context 'given valid credentials' do
      before do
        @user_session = stub 'user session'
        @user_session.
          stubs(:save).
          with().
          returns(true)

        @params = {}
        UserSession.
          stubs(:new).
          with(@params).
          returns(@user_session)

        post :create, 
          :user_session => @params
      end

      it 'creates a new user session' do
        UserSession.should have_received(:new).with(@params)
        @user_session.should have_received(:save).with()
      end

      it 'redirects to the homepage' do
        response.should redirect_to root_path
      end
    end

    context 'given invalid credentials' do
      before do
        @user_session = stub 'user session'
        @user_session.
          stubs(:save).
          with().
          returns(false)

        @params = {}
        UserSession.
          stubs(:new).
          with(@params).
          returns(@user_session)

        post :create, 
          :user_session => @params
      end

      it 'sets a flash message' do
        flash[:error].should be
      end

      it 'redirects to the login page' do
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe '#destroy' do
    before do
      @user_session = stub 'user session'
      @user_session.
        stubs(:destroy).
        with()

      UserSession.
        stubs(:find).
        with().
        returns(@user_session)

      session[:user_credentials_id] = 1

      delete :destroy
    end

    it 'deletes the current user session' do
      UserSession.should have_received(:find).with()
      @user_session.should have_received(:destroy).with()
      session[:user_credentials_id].should_not be
    end

    it 'redirects to the homepage' do
      response.should redirect_to root_path
    end
  end

end
