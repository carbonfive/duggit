require 'spec_helper'

describe VotesController do

  describe '#create' do
    context 'given someone else submitted this link' do
      before do
        linker = Factory :user
        link = Factory :link, :author => linker

        voter = Factory :user
        login voter

        post :create, :link_id => link.id, :vote => { :value => 1 }

        @votes = Vote.where(:user_id => voter.id).where(:link_id => link.id)
      end

      it 'saves the vote' do
        @votes.should have(1).vote
        @votes.first.value.should == 1
      end

      it 'redirects me to the home page' do
        response.should redirect_to(root_path)
      end
    end

    context 'given I submitted this link' do
      before do
        linker = Factory :user
        link = Factory :link, :author => linker
        login linker

        post :create, :link_id => link.id, :vote => { :value => 1 }

        @votes = Vote.where(:user_id => linker.id).where(:link_id => link.id)
      end

      it 'does NOT save the vote' do
        @votes.should have(0).votes
      end
    end

  end

  describe '#update' do
    before do
      linker = Factory :user
      link = Factory :link, :author => linker

      voter = Factory :user
      vote = Vote.create :link => link, :user => voter, :value => 1
      login voter

      put :update, :link_id => link.id, :id => vote.id, :vote => { :value => -1 }

      @votes = Vote.where(:user_id => voter.id).where(:link_id => link.id)
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