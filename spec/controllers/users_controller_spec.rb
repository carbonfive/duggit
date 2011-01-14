require 'spec_helper'

describe UsersController do
  describe '#new' do
    before do
      get :new
    end

    it 'displays the registration page' do
      response.should render_template(:new)
    end
  end

  describe '#create' do
    context  'given a username and password' do
      before do
        @count = User.count
        post :create,
             :user => { :username => 'iceman', :password => 'dangerous' }
        @user = assigns(:user)
      end

      it 'creates a new user' do
        User.count.should == @count + 1
        @user.should be
      end

      it 'with the username and password' do
        @user.username.should == 'iceman'
        @user.password.should == 'dangerous'
      end

      it 'redirects us to the home page' do
        response.should redirect_to root_path
      end
    end

  end
end
