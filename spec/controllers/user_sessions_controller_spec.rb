require 'spec_helper'

describe UserSessionsController do
  describe '#new' do
    before do
      get :new
    end

    it 'initializes a new user session' do
      assigns(:user_session).should be_a_new(UserSession)
    end
  end

  describe '#create' do
    context 'given a valid login' do
      before do
        @user = Factory :user
        post :create, :user_session => { :username => @user.username, :password => @user.password }
      end

      it 'creates a new user session' do
        session[:user_credentials_id].should == @user.id
      end

      it 'redirects to the home page' do
        response.should redirect_to(root_path)
      end
    end

    context 'given an invalid login' do
      before do
        @user = Factory :user
        post :create, :user_session => { :username => @user.username, :password => 'garbage' }
      end

      it 'does not log me in' do
        session[:user_credentials].should_not be
      end

      it 'goes back to the login page' do
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe '#destroy' do
    before do
      user = Factory :user
      session[:user_credentials_id] = user.id
      delete :destroy
    end

    it 'deletes the current user session' do
      session[:user_credentials_id].should_not be
    end

    it 'redirects to the home page' do
      response.should redirect_to(root_path)
    end
  end
end