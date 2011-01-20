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
end