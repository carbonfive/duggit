require 'spec_helper'

describe UsersController do

  describe '#new' do
    before do
      @user = stub 'user'
      User.
        stubs(:new).
        with().
        returns(@user)

      get :new
    end

    it 'creates a new user' do
      User.should have_received(:new).with()
      assigns(:user).should == @user
    end

    it 'displays the registration page' do
      response.should render_template :new
    end
  end

  describe '#create' do
    before do
      @params = {}
      User.
        stubs(:create).
        with(@params)
        
      post :create,
        :user => @params
    end

    it 'creates a new user' do
      User.should have_received(:create).with(@params)
    end

    it 'redirects to the homepage' do
      response.should redirect_to root_path
    end
  end

end
