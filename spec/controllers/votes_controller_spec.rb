require 'spec_helper'

describe VotesController do
  before do
    @user1 = Factory :user
    @user2 = Factory :user
  end

  describe '#create' do
    context 'Someone else submitted this link' do
      before do
        link = Factory :link, :author => @user1
        login(@request, @user2)

        post :create, :link_id => link.id, :vote => { :value => 1 }

        @votes = Vote.where(:user_id => @user2.id).where(:link_id => link.id)
      end

      it 'saves the vote' do
        @votes.length.should == 1
        @votes.first.value.should == 1
      end

      it 'redirects me to the home page' do
        response.should redirect_to(root_path)
      end
    end

    context 'I submitted this link' do
      before do
        link = Factory :link, :author => @user1
        login(@request, @user1)

        post :create, :link_id => link.id, :vote => { :value => 1 }

        @votes = Vote.where(:user_id => @user1.id).where(:link_id => link.id)
      end

      it 'saves nothing' do
        @votes.length.should == 0
      end
    end

  end

  describe '#update' do
    before do
      link = Factory :link, :author => @user1
      vote = Vote.create :link => link, :user => @user2, :value => 1
      login(@request, @user2)

      put :update, :link_id => link.id, :id => vote.id, :vote => { :value => -1 }

      @votes = Vote.where(:user_id => @user2.id).where(:link_id => link.id)
    end

    it 'updates the vote' do
      @votes.length.should == 1
      @votes.first.value.should == -1
    end

    it 'redirects me to the home page' do
      response.should redirect_to(root_path)
    end
  end
  
end